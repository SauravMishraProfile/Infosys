//
//  DataFeed.swift
//  Infosys
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

struct DataFeed: Codable {
    let title: String
    let rows: [Rows]

    struct Rows: Codable {
        let title: String?
        let description: String?
        let imageHref: String?
    }
}
