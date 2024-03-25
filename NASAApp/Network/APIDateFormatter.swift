//  APIDateFormatter.swift
//  NASAApp
//  Created by Валерия Устименко on 18.03.2024.

import Foundation

struct APIDateFormatter {
	static let shared = APIDateFormatter()
	
	private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = ConstantsAPI.dateFormatter
		return formatter
	}()
	
	func string(from date: Date) -> String {
		return dateFormatter.string(from: date)
	}
	
	func dateMinusMonths(_ months: Int, from date: Date) -> String {
		let calendar = Calendar.current
		if let dateMinusMonths = calendar.date(byAdding: .month, value: -months, to: date) {
			return dateFormatter.string(from: dateMinusMonths)
		} else {
			return dateFormatter.string(from: date)
		}
	}
	private init() {}
}
