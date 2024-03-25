//  SearchResultsCollectionView.swift
//  NASAApp
//  Created by Валерия Устименко on 18.03.2024.

import UIKit

private enum ConstSearchCollection {
	static let collectionViewHight: CGFloat = 200
}

final class SearchResultsCollectionView: UICollectionView {
	
	// MARK: - Lifecycle
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		setupCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError(Constants.textFatalError)
	}
	
	// MARK: - Configure
	private func setupCollectionView() {
		backgroundColor  = .black
		showsVerticalScrollIndicator = false
		contentInset = Constants.collectionViewInsets
		register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
		
		if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .vertical
			flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: ConstSearchCollection.collectionViewHight)
		}
	}
}
