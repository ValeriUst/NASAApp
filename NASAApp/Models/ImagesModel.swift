//  ImagesModel.swift
//  NASAApp
//  Created by Валерия Устименко on 28.02.2024.

import Foundation

struct ImagesModel: Decodable {
	let date, explanation: String?
	let hdurl: String?
	let title: String?
	let url: String?
}
