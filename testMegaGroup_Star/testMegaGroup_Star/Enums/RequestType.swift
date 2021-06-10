//
//  RequestType.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//

import Foundation

enum RequestType {
	//case firstRequest(String)
	case pageNumberRequest(String, Int)
	case userCommentsRequest(String, Int)
	
	var url: URL? {
		URL(string: stringURL)
	}
	
	private var stringURL: String {
		switch self {
			//			case .firstRequest(let defaultURL):
			//				return defaultURL
			case .pageNumberRequest(let defaultURL, let pageNumber):
				return defaultURL + "?_page=" + String(pageNumber)
			case .userCommentsRequest(let defaultURL, let postId):
				return defaultURL + "/" + String(postId) + "/comments"
		}
	} // stringURL
	
}
