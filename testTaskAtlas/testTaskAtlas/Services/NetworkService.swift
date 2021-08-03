//
//  NetworkService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class NetworkService {
	
	static let shared = NetworkService()
	let apiKeyForNews = "63ecf6c4a47c45e4a161941fa048bc33" // в тестовом api нет смысла выносить
	let stringUrlForNews = "https://newsapi.org/v2/everything"
	
	/// Loads news
	func loadItems(pageNumber: Int, loadMore: Bool? = nil,
								 completion: @escaping (Result<[Article], ErrorType>) -> ()) {
		
		// cursora нет, header/api внутри, поэтому без RequestType сортировки и пр. настроек - в 1 строку
		let defaultURL = "\(stringUrlForNews)?q=ios&pageSize=20&page=\(pageNumber)&apiKey=\(apiKeyForNews)"
		
		guard let url = URL(string: defaultURL) else { return }
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data
			else { completion(.failure(.requestFailed))
				return }
			do {
				let receivedData = try JSONDecoder().decode(NewsResponse?.self, from: data)
				guard let articles = receivedData?.articles else { completion(.failure(.invalidData))
					return }
				completion(.success(articles))
			} catch {
				completion(.failure(.invalidData))
			}
		}.resume()
	}
	
}
