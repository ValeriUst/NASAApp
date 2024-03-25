//  ImagesViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit
import SnapKit

private enum ConstImage {
	static let inset: CGFloat = 2
	static let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	static let cellHeight: CGFloat = 200
}

final class ImagesViewController: UIViewController {
	
	// MARK: - Property
	private var model: [ImagesModel] = []
	private var headerView: HeaderViewImages?
	
	// MARK: - Computer Property
	private var cellPadding: CGFloat {
		isIPhoneSE ? 10 : 15
	}
	private var isIPhoneSE: Bool {
		view.bounds.width == 320
	}
	private var compilationCellWidthAndHeight: CGFloat {
		(view.bounds.width - cellPadding - (Constants.standardInsets * 2)) / ConstImage.inset
	}
	
	private var initialImageHeight: CGFloat {
		return UIScreen.main.bounds.height / 2
	}
	
	// MARK: - Content
	private let collectionViewImages = ImagesCollectionView(frame: .zero,
															collectionViewLayout: StretchyHeaderLayout())
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViews()
		fetchDataImages()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	private func configureViews() {
		view.addSubviews([collectionViewImages])
		collectionViewImages.delegate = self
		collectionViewImages.dataSource = self
		collectionViewImages.frame = view.bounds

		let layout = StretchyHeaderLayout()
		layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: initialImageHeight)
	}
	
	//MARK: - Methods
	private func fetchDataImages() {
		APICaller.shared.getImagesNASA() { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let model):
				self.model = model
				DispatchQueue.main.async {
					self.collectionViewImages.reloadData()
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return model.count - 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.identifier,
															for: indexPath) as? ImagesCell else {
			return UICollectionViewCell()
		}
		let title = model[indexPath.row + 1]
		cell.configure(with: title)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
																			 withReuseIdentifier: HeaderViewImages.identifier,
																			 for: indexPath) as! HeaderViewImages
			if let firstModel = model.first {
				header.configureHeroView(with: firstModel)
			}
			return header
		}
		return UICollectionReusableView()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = DetailsViewController()
		let title = model[indexPath.row + 1]
		vc.configureDetails(with: title)
		navigationController?.pushViewController(vc, animated: true)
	}
	
// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: view.bounds.width, height: ConstImage.cellHeight)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: compilationCellWidthAndHeight, height: compilationCellWidthAndHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return ConstImage.insets
	}
}
