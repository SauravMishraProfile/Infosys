//
//  HomeService.swift
//  Infosys
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import NetworkClient

protocol HomeServiceProvider: AnyObject {
    func fetchHomeData(completion: @escaping (Response<DataFeed>) -> Void)
}


final class HomeService: RequestPerforming {
    typealias ErrorModel = DefaultErrorModel
    typealias SuccessModel = DataFeed

    let parameters: [String: Any] = [:]
    let type: RequestType = .get
    let encodingStrategy: String.Encoding = .isoLatin1
    let host: String = "dl.dropboxusercontent.com"
    let uri: String = "/s/2iodh4vg0eortkl/facts.json"
}

extension HomeService: HomeServiceProvider {
    func fetchHomeData(completion: @escaping (Response<DataFeed>) -> Void) {
        performRequest(completion: completion)
    }
}
