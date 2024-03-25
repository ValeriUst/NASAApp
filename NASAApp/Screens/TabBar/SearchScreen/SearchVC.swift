//  SearchViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

final class SearchViewController: UIViewController {
	
	// MARK: - Property
	private var model: [Item] = []
		
	private var hasMoreData: Bool = true
	private var isFetching: Bool = false
	private var currentPage: Int = 1
	
	// MARK: - Content
	private let searchResultsCollectionView = SearchResultsCollectionView (frame: .zero,
															collectionViewLayout: UICollectionViewFlowLayout())
	private let searchBar = SearchBar()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViews()
	}
	
	// MARK: - Configure
	private func configureViews() {
		view.addSubviews([searchBar, searchResultsCollectionView])
		searchResultsCollectionView.frame = view.bounds
		setupKeyboard()
		configureNavigation()
		delegateViews()
	}

	private func delegateViews() {
		searchBar.delegate = self
		searchResultsCollectionView.delegate = self
		searchResultsCollectionView.dataSource = self
	}
	
	private func configureNavigation() {
		navigationItem.titleView = searchBar
		navigationController?.navigationBar.barTintColor = .black
		searchResultsCollectionView.frame = view.bounds
	}
	
	// MARK: - Methods
	private func fetchDataSearch(keywords: String, page: Int = 1) {
		guard !isFetching else { return }
		isFetching = true

		APICaller.shared.getSearch(keywords: keywords, page: page) { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.isFetching = false
			}
			switch result {
			case .success(let model):
				guard let newItems = model.collection.items else { return }
					
				self.hasMoreData = newItems.count >= 20
				
				if page == 1 {
					self.model = newItems
				} else {
					self.model.append(contentsOf: newItems)
				}
				DispatchQueue.main.async {
					self.searchResultsCollectionView.reloadData()
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	private func loadMoreContentIfNeeded(currentItemIndex: Int) {
		if currentItemIndex == model.count - 1 { // Предзагрузка следующей страницы
			currentPage += 1
			fetchDataSearch(keywords: searchBar.text ?? "", page: currentPage)
		}
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return model.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier,
															for: indexPath) as? SearchCell else {
			return UICollectionViewCell()
		}
		let title = model[indexPath.row]
		cell.configure(with: title)
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = collectionView.bounds.width - (Constants.standardInsets * 2)
		let cellHeight = UIScreen.main.bounds.height / 5
		return CGSize(width: cellWidth, height: cellHeight)
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		let isLastCell = indexPath.row == model.count - 1
		
		if isLastCell && hasMoreData && !isFetching {
			currentPage += 1
			fetchDataSearch(keywords: searchBar.text ?? "", page: currentPage)
		}
	}
}

// MARK: - Extension UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		fetchDataSearch(keywords: "")
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		searchBar.resignFirstResponder()
		currentPage = 1
		fetchDataSearch(keywords: searchText)
	}
}
