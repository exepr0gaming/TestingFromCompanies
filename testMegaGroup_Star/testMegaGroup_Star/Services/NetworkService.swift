//
//  NetworkService.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//

import Foundation



public final class NetworkService {
	
	/// Loads posts with chosen sortType
	static func loadUserPosts(url: String,
														pageNumber: Int?,
														loadMore: Bool? = nil,
														completion: @escaping (Result<[User], ErrorType>) -> ()) {
		let requestForPosts: URL?
		requestForPosts = RequestType.pageNumberRequest(url, pageNumber!).url
		guard let requestURL = requestForPosts else { return }
		URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
			guard let data = data	else { completion(.failure(.requestFailed)); return }
			do {
				if let usersData = try JSONDecoder().decode([User]?.self, from: data) {
					completion(.success(usersData))
				}
			} catch {
				completion(.failure(.invalidData))
			}
		}.resume()
	}
	
	static func loadUserComments(url: String, postId: Int, completion: @escaping (Result<[UserComments], ErrorType>) -> ()) {
		let requestForUserComments: URL?
		requestForUserComments = RequestType.userCommentsRequest(url, postId).url
		guard let requestURL = requestForUserComments else { return }
		URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
			guard let data = data	else { completion(.failure(.requestFailed)); return }
			do {
				if let userComments = try JSONDecoder().decode([UserComments]?.self, from: data) {
					completion(.success(userComments))
				}
			} catch {
				completion(.failure(.invalidData))
			}
		}.resume()
	}
	
} // NetworkService

