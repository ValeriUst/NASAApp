//  MainTabBarViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

private enum ConstMain {
	static let photoLabel: String = "Фото дня"
	static let searchLabel: String = "Поиск"
	static let photoSystemName: String = "photo.on.rectangle.angled"
	static let imageSystemName: String = "magnifyingglass"
}

final class MainTabBarViewController: UITabBarController {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewControllers()
		setTabBarAppearance()
	}
	
	//MARK: - Methods
	private func setupViewControllers() {
		let vc1 = UINavigationController(rootViewController: ImagesViewController())
		let vc2 = UINavigationController(rootViewController: SearchViewController())
		
		setViewControllers([vc1, vc2], animated: true)
		
		let tabBarItem1 = UITabBarItem(title: ConstMain.photoLabel,
									   image: UIImage(systemName: ConstMain.photoSystemName),
									   selectedImage: nil)
		let tabBarItem2 = UITabBarItem(title: ConstMain.searchLabel,
									   image: UIImage(systemName: ConstMain.imageSystemName),
									   selectedImage: nil)
		vc1.tabBarItem = tabBarItem1
		vc2.tabBarItem = tabBarItem2
	}
	
	private func setTabBarAppearance() {
		tabBar.tintColor = .white
		tabBar.barTintColor = .black
		tabBar.unselectedItemTintColor = .gray
	}
}
