//
//  JsonPostsModel.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//

import Foundation

// MARK: - Users
struct User: Codable {
	let userId, id: Int
	let title, body: String
}

// MARK: - UserComments
struct UserComments: Codable {
	let postId, id: Int
	let name, email, body: String
}

