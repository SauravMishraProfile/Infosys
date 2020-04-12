//
//  HomeTableViewCell.swift
//  Infosys
//
//  Created by Saurav Mishra on 12/4/20.
//  Copyright © 2020 Saurav Mishra. All rights reserved.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = .titleLabel()
    lazy var descriptionLabel: UILabel = .descriptionLabel()
    private lazy var descriptionImageView: UIImageView = .descriptionImageView()
    private lazy var verticalStackView: UIStackView = .verticalStackView(arrangedSubViews: [titleLabel, descriptionLabel])
    private lazy var horizontalStackView: UIStackView = .horizontalStackView(arrangedSubViews: [descriptionImageView, verticalStackView])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(horizontalStackView)
        addConstraints()
    }

    private func addConstraints() {
        descriptionImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }

        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(16)
            make.bottom.equalTo(contentView.snp.bottom).inset(8).priority(.medium)
            make.leading.equalTo(contentView.snp.leading).inset(20)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Should not instantiate from nib")
    }
}

private extension UILabel {
    static func titleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }

    static func descriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
}

private extension UIImageView {
    static func descriptionImageView() -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: "desert"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }
}

private extension UIStackView {
    static func verticalStackView(arrangedSubViews: [UIView]) -> UIStackView {
        let labelStackView = UIStackView(arrangedSubviews: arrangedSubViews)
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.alignment = .fill
        labelStackView.spacing = 4
        return labelStackView
    }

    static func horizontalStackView(arrangedSubViews: [UIView]) -> UIStackView {
        let horizontalStackView = UIStackView(arrangedSubviews: arrangedSubViews)
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .top
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 16
        return horizontalStackView
    }
}
