//
//  NetworkService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import Foundation

class Validators {
	
	static func isFilledLogin(login: String?, password: String?) -> Bool {
		guard let login = login, let password = password,
					login != "", password != "" else { return false }
		return true
	}
	
	static func passwordMinSixChars(password: String?) -> Bool {
		guard let passwordCount = password?.count,
					passwordCount >= 6 else { return false }
		return true
	}
	
}
