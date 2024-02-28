//  SearchViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

final class SearchViewController: UIViewController {
	
	// MARK: - Constants
	
	// MARK: - Content
	private let collectionViewSearch = UICollectionView(frame: .zero,
														collectionViewLayout: UICollectionViewFlowLayout())

	private let searchBar: UISearchBar = {
		let search = UISearchBar()
		search.tintColor = .white
		search.barTintColor = .clear
		search.placeholder = "Найти"
		search.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		search.layer.cornerRadius = Constants.cornerRadiusStandard
		return search
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViews()
		configureNavigation()
	}
	
	// MARK: - Configure
	private func setupCollectionView() {
		collectionViewSearch.delegate = self
		collectionViewSearch.dataSource = self
		collectionViewSearch.backgroundColor  = .black
		collectionViewSearch.showsVerticalScrollIndicator = false
		collectionViewSearch.contentInset = Constants.collectionViewInsets
		collectionViewSearch.register(SearchCell.self,
									  forCellWithReuseIdentifier: SearchCell.identifier)
		if let flowLayout = collectionViewSearch.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .vertical
		}
	}
	
	private func configureViews() {
		view.addSubviews([searchBar, collectionViewSearch])
		setConstraints()
		setupCollectionView()
		setupKeyboard()
		searchBar.delegate = self
	}
	
	private func configureNavigation() {
		navigationItem.titleView = searchBar
		navigationController?.navigationBar.barTintColor = .black
	}
	
	//MARK: - Methods
	
	// MARK: - Constraints
	private func setConstraints() {
		collectionViewSearch.snp.makeConstraints { collection in
			collection.top.leading.trailing.bottom.equalToSuperview()
		}
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 30
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier,
															for: indexPath) as? SearchCell else {
			return UICollectionViewCell()
		}
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = collectionView.bounds.width - (16 * 2)
		let cellHeight = UIScreen.main.bounds.height / 5
		return CGSize(width: cellWidth, height: cellHeight)
	}
}

// MARK: - Extension UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	// Обработка нажатия на кнопку поиска
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		searchBar.resignFirstResponder() // Скрыть клавиатуру
	}
	
	// Редактирование searchBar
	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}
}
