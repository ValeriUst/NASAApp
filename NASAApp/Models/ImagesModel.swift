//  ImagesModel.swift
//  NASAApp
//  Created by Валерия Устименко on 28.02.2024.

import Foundation

//struct ImagesModel: Decodable {
//	let copyright: String?
//	let date: String?
//	let explanation: String?
//	let url: String?
//	let title: String?
//}
struct ImagesModel: Codable {
	let copyright, date, explanation: String?
	let hdurl: String?
	let mediaType, serviceVersion, title: String?
	let url: String?
	
	enum CodingKeys: String, CodingKey {
		case copyright, date, explanation, hdurl
		case mediaType = "media_type"
		case serviceVersion = "service_version"
		case title, url
	}
}
