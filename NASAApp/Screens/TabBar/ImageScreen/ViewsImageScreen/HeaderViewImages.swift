//  HeaderViewImages.swift
//  NASAApp
//  Created by Валерия Устименко on 01.03.2024.

import UIKit
import Kingfisher

final class HeaderViewImages: UICollectionReusableView {
	
	// MARK: - Constants
	static let identifier = "HeaderViewImages"
	
	// MARK: - Constants
	private let heroImageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = Constants.cornerRadiusStandard
		return image
	}()
	
	// MARK: - Setup UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError(Constants.textFatalError)
	}
	
	// MARK: - Configure View
	func configureHeroView(with model: ImagesModel) {
		if let urlString = model.url, let url = URL(string: urlString) {
			let options: KingfisherOptionsInfo = [.transition(.fade(0.2)), .cacheOriginalImage]
			heroImageView.kf.setImage(with: url,
									  placeholder: UIImage(named: Constants.nilPhoto),
									  options: options)
		} else {
			heroImageView.image = UIImage(named: Constants.nilPhoto)
		}
	}
	
	private func configureViews() {
		addSubview(heroImageView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		heroImageView.frame = bounds
	}
}
