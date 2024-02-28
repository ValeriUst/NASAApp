//  ImagesCell.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit
import Kingfisher

final class ImagesCell: UICollectionViewCell {
	
	// MARK: - Constants
	static let identifier = "ImageCell"
	
	// MARK: - Constants
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "galaxy")
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
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Configure
	func configure(with model: ImagesModel) {
		nameLabel.text = model.title ?? ""
		if let urlString = model.url, let url = URL(string: urlString) {
			imageView.kf.setImage(with: url)
		} else {
			imageView.image = UIImage(named: "placeholder_image")
		}
	}
	
	private func setupCell() {
		layer.cornerRadius = Constants.cornerRadiusStandard
		layer.masksToBounds = true
	}
	
	private func configureViews() {
		addSubviews([imageView, nameLabel])
		setupCell()
		setConstraints()
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
