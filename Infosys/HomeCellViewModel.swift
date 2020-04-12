//
//  HomeCellViewModel.swift
//  Infosys
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import Foundation

struct HomeCellViewModel {
    let imageURLString: String?
    let title: String?
    let description: String?
    let placeHolderImageName = "Placeholder"

    init?(imageURLString: String?, title: String?, description: String?) {
        if imageURLString.isNil() && title.isNil() && description.isNil() {
            return nil
        }
        self.imageURLString = imageURLString
        self.title = title
        self.description = description
    }

    var shouldDownloadImage: Bool {
        return url.isNil() == false
    }

    var shouldHideTitleLabel: Bool {
        return title.isNil()
    }

    var shouldHideDescriptionLabel: Bool {
        return description.isNil()
    }

    var url: URL? {
        guard let imageURLString = imageURLString else { return nil}
        return URL(string: imageURLString)
    }

}

private extension Optional {
    func isNil() -> Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
}
