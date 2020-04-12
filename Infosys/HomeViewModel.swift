//
//  HomeViewModel.swift
//  Infosys
//
//  Created by Saurav Mishra on 11/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import NetworkClient

final class HomeViewModel {

    private let service: HomeServiceProvider
    init(service: HomeServiceProvider = HomeService()) {
        self.service = service
    }
    
    func fetchData() {
        self.service.fetchHomeData { [weak self] result in
            switch result {
            case .success(let dataFeed):
                self?.processSuccessResponse(model: dataFeed)
            case .failure(let error):
                self?.processFailureResponse(errorModel: error)
            }
        }
    }
    
    private func processSuccessResponse(model: DataFeed) {
        
    }
    
    private func processFailureResponse(errorModel: Codable) {
        
    }
}

struct HomeCellViewModel {
    
}
