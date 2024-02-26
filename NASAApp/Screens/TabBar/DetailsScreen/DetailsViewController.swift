//  DetailsViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

final class DetailsViewController: UIViewController {
	
	// MARK: - Constants
	
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.contentInsetAdjustmentBehavior = .never
		return scroll
	}()
	
	private let viewContainer: UIView = {
		let viewContainer = UIView()
		return viewContainer
	}()
	
	private let imageDetail: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "galaxy")
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = Constants.cornerRadiusStandard
		return image
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "kdkdkkdkdkd kdkdkkdkdkd"
		label.textColor = .white
		label.font = .systemFont(ofSize: Constants.titleFont, weight: .bold)
		return label
	}()
	private let storyLabel: UILabel = {
		let label = UILabel()
		label.text = "kdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkdkdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkdkdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkd kdkdkkdkdkd"
		label.textColor = .white
		label.font = .systemFont(ofSize: Constants.storyFont)
		label.numberOfLines = Constants.numberOfLinesStory
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupAddSubviews()
		setConstraints()
	}
	
	private func setupAddSubviews() {
		view.addSubviews([scrollView])
		scrollView.addSubviews([viewContainer])
		viewContainer.addSubviews([imageDetail, titleLabel, storyLabel])
	}
	
	// MARK: - Configure
	
	//MARK: - Methods
	
	// MARK: - Constraints
	private func setConstraints() {
		scrollView.snp.makeConstraints { scroll in
			scroll.top.leading.trailing.bottom.equalToSuperview()
		}
		viewContainer.snp.makeConstraints { view in
			view.edges.equalTo(scrollView)
			view.width.equalTo(scrollView.snp.width)
			view.height.equalTo(Constants.heightContainer)
		}
		imageDetail.snp.makeConstraints { image in
			image.top.trailing.leading.equalTo(viewContainer)
			image.height.equalTo(300)
		}
		titleLabel.snp.makeConstraints { label in
			label.top.equalTo(imageDetail.snp.bottom).offset(Constants.standartTop)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standartInsets)
		}
		storyLabel.snp.makeConstraints { label in
			label.top.equalTo(titleLabel.snp.bottom).offset(Constants.standartTop)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standartInsets)
			label.trailing.equalTo(viewContainer.snp.trailing).inset(Constants.standartInsets)
		}
	}
}
