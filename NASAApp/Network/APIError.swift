//  APIError.swift
//  NASAApp
//  Created by Валерия Устименко on 28.02.2024.

import Foundation

enum APIError: Error {
	case failedToGetData
	case invalidURL
	case failedToDecodeData
}
