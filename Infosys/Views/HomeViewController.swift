//
//  ViewController.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit
import SnapKit

/// Landing View Controller on App launch
class HomeViewController: UIViewController, ViewModelInjectable {

    // MARK: - Properties

    // MARK: Internal
    var viewModel: HomeViewModel! = HomeViewModel() {
        didSet {
            viewModel.delegate = self
        }
    }

    weak var coordinator: HomeCoordinator!

    // MARK: Private

    private lazy var tableView =  UITableView(frame: .zero)
    private lazy var refreshControl = UIRefreshControl()
    private lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        assertDependencies()

        setUpTableView()
        setUpActivityIndicator()

        viewModel.fetchData()
    }
}

// MARK: - Extensions

// MARK: Private
private extension HomeViewController {

    private enum Constants {
        static let cellID = "cellID"
    }

    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc
    func refresh(sender: UIRefreshControl) {
        viewModel.fetchData()
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as? HomeTableViewCell else {
            assertionFailure("Unable To Dequeue cell")
            return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
}

// MARK: HomeServiceDelegate

extension HomeViewController: HomeServiceDelegate {

    func didSucceed(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshingIfNecessary()
            self.title = viewModel.screenTitle
            self.tableView.reloadData()
        }
    }

    func didFail(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshingIfNecessary()
            let alert = UIAlertController(title: HomeViewModel.ErrorState.generaltitle, message: HomeViewModel.ErrorState.message(for: viewModel.errorModel?.type), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: HomeViewModel.ErrorState.done, style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func didStartLoading(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.tableView.isHidden = true
        }
    }
}

// MARK: Private Extensions

private extension UIRefreshControl {
    func endRefreshingIfNecessary() {
        if isRefreshing {
            endRefreshing()
        }
    }
}
