//
//  HomeViewModel.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import NetworkClient

protocol HomeServiceDelegate: AnyObject {
    func didSucceed(_ viewModel: HomeViewModel)
    func didFail(_ viewModel: HomeViewModel)
}

final class HomeViewModel {

    enum State {
        case initial
        case loading
        case success
        case failure
    }

    weak var delegate: HomeServiceDelegate?
    private(set) var state: State = .initial {
        didSet {
            switch state {
            case .success:
                delegate?.didSucceed(self)
            case .failure:
                delegate?.didFail(self)
            default:
                break
            }
        }
    }

    private let service: HomeServiceProvider
    private(set) var cellViewModels: [HomeCellViewModel] = []
    private(set) var screenTitle: String?

    init(service: HomeServiceProvider = HomeService()) {
        self.service = service
    }

    func fetchData() {
        self.service.fetchHomeData { [weak self] result in
            switch result {
            case .success(let dataFeed):
                self?.processSuccessResponse(model: dataFeed)
                self?.state = .success
            case .failure(let error):
                self?.processFailureResponse(errorModel: error)
                self?.state = .failure
            }
        }
    }

    private func processSuccessResponse(model: DataFeed) {
        screenTitle = model.title
        cellViewModels = model.rows.compactMap { HomeCellViewModel(imageURLString: $0.imageHref, title: $0.title, description: $0.description) }
    }

    private func processFailureResponse(errorModel: Codable) {

    }

}
