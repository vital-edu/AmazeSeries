//
//  SeriesViewCell.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import UIKit
import Kingfisher

class SeriesViewCell: UICollectionViewCell {
    static let identifier = String(describing: self)

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()

    private lazy var mainView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(titleLabel)

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViews() {
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textAlignment = .center
    }

    func setup(with model: Series) {
        posterImageView.kf.setImage(with: model.poster.mediumImageUrl)
        titleLabel.text = model.name
    }
}

extension SeriesViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(mainView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
