//  SearchBar.swift
//  NASAApp
//  Created by Валерия Устименко on 18.03.2024.

import UIKit

final class SearchBar: UISearchBar {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSearchBar()
	}
	
	required init?(coder: NSCoder) {
		fatalError(Constants.textFatalError)
	}
	
	private func setupSearchBar() {
		self.tintColor = .white
		self.barTintColor = .clear
		self.placeholder = Constants.placeholder
		self.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		self.layer.cornerRadius = Constants.cornerRadiusStandard
		self.clipsToBounds = true
	}
}
