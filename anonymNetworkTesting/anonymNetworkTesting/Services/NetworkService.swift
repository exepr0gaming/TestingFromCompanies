//
//  NetworkService.swift
//  anonymNetworkTesting
//
//  Created by Курдин Андрей on 02.06.2021.
//

import Foundation

//protocol URLSessionProtocol {
//	func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//}
//
//extension URLSession: URLSessionProtocol {}

public final class NetworkService {
	
	//var urlSession: URLSessionProtocol = URLSession.shared
	
	/// Loads posts with chosen sortType
	 static func loadItems(sort: SortType? = nil,
											 loadMore: Bool? = nil,
											 completion: @escaping (Result<[Item], ErrorType>) -> ()) {
		let defaultURL = "https://k8s-stage.apianon.ru/posts/v1/posts"
		var requestURL: URL?
		
		if loadMore == false { UserDefaultsService.shared.nextPageCursor = "" }
		
		switch sort {
			case .notSorted:
				requestURL = RequestType.defaultRequest(defaultURL, UserDefaultsService.shared.nextPageCursor).url
			case .createdAt:
				requestURL = RequestType.sortedByDate(defaultURL, UserDefaultsService.shared.nextPageCursor).url
			case .mostPopular:
				requestURL = RequestType.sortedByPopularity(defaultURL, UserDefaultsService.shared.nextPageCursor).url
			case .mostCommented:
				requestURL = RequestType.sortedByComments(defaultURL, UserDefaultsService.shared.nextPageCursor).url
			case .none:
				requestURL = RequestType.firstRequest(defaultURL).url
		}
		
		guard let request = requestURL else { return }
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			guard let data = data else { completion(.failure(.requestFailed))
				return }
			do {
				let receivedData = try JSONDecoder().decode(AnonymNetworkJSON?.self, from: data)
				guard let mainData = receivedData?.data else { completion(.failure(.invalidData))
					return }
				let parsedData = mainData.items
				let cursor = mainData.cursor
				UserDefaultsService.shared.nextPageCursor = cursor?.replacingOccurrences(of: "+", with: "%2B") ?? ""
				completion(.success(parsedData))

		} catch {
				completion(.failure(.invalidData))
		
			}
		}.resume()
	}
	
}
