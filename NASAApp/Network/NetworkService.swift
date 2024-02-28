//  NetworkService.swift
//  NASAApp
//  Created by Валерия Устименко on 26.02.2024.

import Foundation
import Alamofire

struct ConstantsAPI {
	static let API_KEY = "swpKyEJKYlYNvwUXL5q59kPnqdjnhhkGpVrgBNR2"
	static let baseURL = "https://api.nasa.gov"
	static let count = "&count="
}

final class APICaller {
	
	static let shared = APICaller()
	
	func getImagesNASA(completion: @escaping (Result<[ImagesModel], Error>) -> Void) {
		
		guard let url = URL(string: "\(ConstantsAPI.baseURL)/planetary/apod?api_key=\(ConstantsAPI.API_KEY)\(ConstantsAPI.count)20") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		AF.request(
			url,
			method: .get,
			parameters: nil,
			headers: nil,
			interceptor: nil
		).validate().responseData { response in
			
			switch response.result {
			case .success(let data):
				do {
					let result = try JSONDecoder().decode([ImagesModel].self, from: data)
					completion(.success(result))
				} catch {
					completion(.failure(APIError.failedToDecodeData))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
