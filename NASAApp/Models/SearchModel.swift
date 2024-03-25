//  SearchModel.swift
//  NASAApp
//  Created by Валерия Устименко on 01.03.2024.

import Foundation

struct SearchModel: Decodable {
	let collection: SearchCollection
}

struct SearchCollection: Decodable {
	let href: String
	let items: [Item]?
}

struct Item: Decodable {
	let links: [Link]?
	let data: [SearchData]?
}

struct Link: Decodable {
	let href: String?
}

struct SearchData: Decodable {
	let title: String?
}
