//  MainTabBarViewController.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

final class MainTabBarViewController: UITabBarController {

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewControllers()
		setTabBarAppearance()
	}
	
	private func setupViewControllers() {
		let vc1 = UINavigationController(rootViewController: ImagesViewController())
		let vc2 = UINavigationController(rootViewController: SearchViewController())
		
		setViewControllers([vc1, vc2], animated: true)
		
		let tabBarItem1 = UITabBarItem(title: "Фото дня", image: UIImage(systemName: "photo.on.rectangle.angled"), selectedImage: nil)
		let tabBarItem2 = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
		
		vc1.tabBarItem = tabBarItem1
		vc2.tabBarItem = tabBarItem2
	}
	
	private func setTabBarAppearance() {
		tabBar.tintColor = .white
		tabBar.backgroundColor = .black
		tabBar.unselectedItemTintColor = .gray
	}
}
