//  ImagesViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit
import SnapKit

final class ImagesViewController: UIViewController {
	
	// MARK: - Constants
	
	private let inset: CGFloat = 2
	
	private let cellInset: CGFloat = 16
	
	private var cellPadding: CGFloat {
		isIPhoneSE ? 10 : 15
	}
	
	private var isIPhoneSE: Bool {
		view.bounds.width == 320
	}
	
	private var compilationCellWidthAndHeight: CGFloat {
		(view.bounds.width - cellPadding - (cellInset * 2)) / inset
	}
	
	// MARK: - Content
	private let collectionViewImages = UICollectionView(frame: .zero,
														collectionViewLayout: UICollectionViewFlowLayout())
	
	private func setupCollectionView() {
		collectionViewImages.delegate = self
		collectionViewImages.dataSource = self
		collectionViewImages.backgroundColor  = .black
		collectionViewImages.showsVerticalScrollIndicator = false
		collectionViewImages.contentInset = Constants.collectionViewInsets
		collectionViewImages.register(ImagesCell.self,
									  forCellWithReuseIdentifier: ImagesCell.identifier)
		if let flowLayout = collectionViewImages.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .vertical
		}
	}

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		view.addSubviews([collectionViewImages])
		setupCollectionView()
		setConstraints()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	// MARK: - Configure
	
	//MARK: - Methods
	
	// MARK: - Constraints
	private func setConstraints() {
		collectionViewImages.snp.makeConstraints { collection in
			collection.edges.equalToSuperview()
		}
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 30
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.identifier,
															for: indexPath) as? ImagesCell else {
			return UICollectionViewCell()
		}
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = DetailsViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
// MARK: - UICollectionViewDelegateFlowLayout

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: compilationCellWidthAndHeight, height: compilationCellWidthAndHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Constants.insets
	}
}
