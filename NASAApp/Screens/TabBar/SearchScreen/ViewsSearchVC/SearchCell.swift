//  SearchCell.swift
//  NASAApp
//  Created by Валерия Устименко on 27.02.2024.

import UIKit
import Kingfisher

final class SearchCell: UICollectionViewCell {
		
	// MARK: - Constants
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		return image
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.numberOfLines = Constants.numberOfLinesCell
		label.textAlignment = .center
		return label
	}()
	
	// MARK: - SetUp UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError(Constants.textFatalError)
	}
	
	// MARK: - Configure
	private func setupCell() {
		layer.cornerRadius = Constants.cornerRadiusStandard
		layer.masksToBounds = true
	}
	
	private func configureViews() {
		addSubviews([imageView, nameLabel])
		setupCell()
		setConstraints()
	}
	
	func configure(with model: Item) {
		nameLabel.text = model.data?.first?.title ?? Constants.errorNameLabel
		if let urlString = model.links?.first?.href, let url = URL(string: urlString) {
			let options: KingfisherOptionsInfo = [.transition(.fade(0.2)), .cacheOriginalImage]
			imageView.kf.setImage(with: url,
								  placeholder: UIImage(named: Constants.nilPhoto),
								  options: options)
		} else {
			imageView.image = UIImage(named: Constants.nilPhoto)
		}
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		imageView.snp.makeConstraints { image in
			image.edges.equalToSuperview()
		}
		
		nameLabel.snp.makeConstraints { label in
			label.centerX.equalTo(imageView.snp.centerX)
			label.bottom.equalTo(imageView.snp.bottom).inset(Constants.cellBottom)
			label.leading.equalToSuperview().offset(Constants.cellInsets)
			label.trailing.equalToSuperview().inset(Constants.cellInsets)
		}
	}
}
