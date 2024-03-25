//  ImagesCollectionView.swift
//  NASAApp
//  Created by Валерия Устименко on 01.03.2024.

import UIKit

final class ImagesCollectionView: UICollectionView {
	
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
		
		register(HeaderViewImages.self,
				 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
				 withReuseIdentifier: HeaderViewImages.identifier)
		
		register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.identifier)
	}
}

final class StretchyHeaderLayout: UICollectionViewFlowLayout {
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		guard let collectionView = collectionView, let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }) else { return nil }
		for attribute in attributes where attribute.representedElementKind == UICollectionView.elementKindSectionHeader && collectionView.contentOffset.y < 0 {
			let width = collectionView.frame.width
			let height = attribute.frame.height - collectionView.contentOffset.y
			attribute.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: width, height: height)
		}
		return attributes
	}
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
}
