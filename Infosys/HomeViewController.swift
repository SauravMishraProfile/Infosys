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

    var viewModel: HomeViewModel! = HomeViewModel()
    weak var coordinator: HomeCoordinator!

    private lazy var tableView =  UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        assertDependencies()
        setUpViews()

        viewModel.perform()
    }
}

private extension HomeViewController {

    private enum Constants {
        static let cellID = "cellID"
    }

    private func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as? HomeTableViewCell
        cell?.titleLabel.text = "Ooooo"
        cell?.descriptionLabel.text = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        return cell ?? UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}

extension HomeViewController: UITableViewDelegate {

}
