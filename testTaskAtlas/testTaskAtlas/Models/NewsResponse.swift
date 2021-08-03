//
//  NewsResponse.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
	let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
	let author: String
	let title: String
	let description: String
	let urlToImage: String?
	let content: String
}
