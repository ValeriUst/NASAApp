//  DetailsViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit
import Kingfisher

private enum ConstDetails {
	static let titleFont: CGFloat = 20
	static let storyFont: CGFloat = 18
	static let numberOfLinesStory: Int = 100
	static let heightContainer: CGFloat = 1200
	static let imageContainer: CGFloat = 300
}

final class DetailsViewController: UIViewController {
	
	// MARK: - Constants
	private var initialImageHeight: CGFloat {
		return UIScreen.main.bounds.height / 2
	}
	
	// MARK: - Content Views
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.contentInsetAdjustmentBehavior = .never
		scroll.showsVerticalScrollIndicator = false
		return scroll
	}()
	
	private let viewContainer: UIView = {
		let viewContainer = UIView()
		return viewContainer
	}()
	
	private let imageDetail: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = Constants.cornerRadiusStandard
		return image
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize: ConstDetails.titleFont, weight: .bold)
		return label
	}()
	
	private let storyLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize: ConstDetails.storyFont)
		label.numberOfLines = ConstDetails.numberOfLinesStory
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.backgroundColor = .clear
	}
	
	// MARK: - Configure
	private func configureViews() {
		view.backgroundColor = .black
		view.addSubviews([scrollView])
		scrollView.addSubviews([viewContainer])
		viewContainer.addSubviews([imageDetail, titleLabel, storyLabel])
		scrollView.delegate = self
		setConstraints()
	}

	// MARK: - Configure
	func configureDetails(with model: ImagesModel) {
		titleLabel.text = model.title ?? Constants.errorNameLabel
		storyLabel.text = model.explanation ?? Constants.errorNameLabel
		if let urlString = model.url, let url = URL(string: urlString) {
			let options: KingfisherOptionsInfo = [.transition(.fade(0.2)), .cacheOriginalImage]
			imageDetail.kf.setImage(with: url,
								  placeholder: UIImage(named: Constants.nilPhoto),
								  options: options)
		} else {
			imageDetail.image = UIImage(named: Constants.nilPhoto)
		}
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		scrollView.snp.makeConstraints { scroll in
			scroll.edges.equalToSuperview()
		}
		viewContainer.snp.makeConstraints { view in
			view.edges.equalTo(scrollView)
			view.width.equalTo(scrollView.snp.width)
			view.height.equalTo(ConstDetails.heightContainer)
		}
		imageDetail.snp.makeConstraints { image in
			image.top.trailing.leading.equalTo(viewContainer)
			image.height.equalTo(ConstDetails.imageContainer)
		}
		titleLabel.snp.makeConstraints { label in
			label.top.equalTo(imageDetail.snp.bottom).offset(Constants.standartTop)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardInsets)
		}
		storyLabel.snp.makeConstraints { label in
			label.top.equalTo(titleLabel.snp.bottom).offset(Constants.standartTop)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardInsets)
			label.trailing.equalTo(viewContainer.snp.trailing).inset(Constants.standardInsets)
		}
	}
}

extension DetailsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let yOffset = scrollView.contentOffset.y
		
		if yOffset < 0 {
			let scaleFactor = 1 + abs(yOffset) / initialImageHeight
			imageDetail.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
			imageDetail.snp.updateConstraints { make in
				make.height.equalTo(initialImageHeight + abs(yOffset))
			}
			imageDetail.layer.cornerRadius = Constants.cornerRadiusStandard * scaleFactor
		} else {
			imageDetail.transform = .identity
			imageDetail.snp.updateConstraints { make in
				make.height.equalTo(initialImageHeight)
			}
			imageDetail.layer.cornerRadius = Constants.cornerRadiusStandard
		}
		
		if yOffset > initialImageHeight / 4 {
			navigationItem.title = titleLabel.text
		} else {
			navigationItem.title = ""
		}
	}
}
