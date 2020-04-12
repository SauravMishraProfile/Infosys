//
//  ViewController.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, ViewModelInjectable {

    var viewModel: HomeViewModel! = HomeViewModel() {
        didSet {
            viewModel.delegate = self
        }
    }

    weak var coordinator: HomeCoordinator!

    private lazy var tableView =  UITableView(frame: .zero)
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        assertDependencies()

        setUpTableView()

        viewModel.fetchData()
    }
}

private extension HomeViewController {

    private enum Constants {
        static let cellID = "cellID"
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

extension HomeViewController: HomeServiceDelegate {
    func didSucceed(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshingIfNecessary()
            self.title = viewModel.screenTitle
            self.tableView.reloadData()
        }
    }

    func didFail(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshingIfNecessary()
            let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

private extension UIRefreshControl {
    func endRefreshingIfNecessary() {
        if isRefreshing {
            endRefreshing()
        }
    }
}
