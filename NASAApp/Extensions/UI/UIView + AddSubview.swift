//  UIView + AddSubview.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import UIKit

extension UIView {
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach {
			addSubview($0);
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
