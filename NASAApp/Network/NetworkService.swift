//  NetworkService.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import Foundation
import Alamofire

final class APICaller {
	
	static let shared = APICaller()
	
	private func performRequest<T: Decodable>(_ url: URL, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
		AF
			.request(url, method: .get)
			.validate()
			.responseData { response in
				
			switch response.result {
			case .success(let data):
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let result = try decoder.decode(decodingType, from: data)
					completion(.success(result))
				} catch {
					completion(.failure(APIError.failedToDecodeData))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	func getImagesNASA(completion: @escaping (Result<[ImagesModel], Error>) -> Void) {
		let dateFormatter = APIDateFormatter.shared.dateMinusMonths(2, from: Date())

		guard let url = URL(string: "\(ConstantsAPI.imageURL)\(ConstantsAPI.planetaryDate)\(dateFormatter)&api_key=\(ConstantsAPI.API_KEY)") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		performRequest(url, decodingType: [ImagesModel].self, completion: completion)
	}
	
	func getSearch(keywords: String?, page: Int, completion: @escaping (Result<SearchModel, Error>) -> Void) {
		let words = keywords?.replacingOccurrences(of: " ", with: ",") ?? ""
		
		guard let url = URL(string: "\(ConstantsAPI.searchURL)\(words)&\(ConstantsAPI.typeSearch)image&\(ConstantsAPI.page)\(page)&\(ConstantsAPI.limit)20") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		performRequest(url, decodingType: SearchModel.self, completion: completion)
	}
}
