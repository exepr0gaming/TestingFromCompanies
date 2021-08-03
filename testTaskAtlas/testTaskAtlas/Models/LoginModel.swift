//
//  LoginModel.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import Foundation

struct Login: Codable {
	var user: String?
	var authenticated: Bool?
	//var error: AuthError?
	
	init(user: String, authenticated: Bool) {
		self.user = user
		self.authenticated = authenticated
	}
	
//	init(error: AuthError) {
//		self.error = error
//	}
}
