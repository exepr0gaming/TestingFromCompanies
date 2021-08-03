//
//  NetworkService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import Foundation

enum UserDefaultsKeys: String {
	case nextPageNumber
	case postsArrayKey
	case authCheck
}

public final class UserDefaultsService {
	
	static let shared = UserDefaultsService()
	
	var nextPageNumber: String {
		get { UserDefaults.standard.string(forKey: UserDefaultsKeys.nextPageNumber.rawValue) ?? "1" }
		set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.nextPageNumber.rawValue) }
	}
	
	var authCheck: Bool {
		get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.authCheck.rawValue) }
		set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.authCheck.rawValue) }
	}
	
	var postsArray: [Article] {
		get {
			guard let encodedData = UserDefaults.standard.array(forKey: UserDefaultsKeys.postsArrayKey.rawValue) as? [Data] else { return [] }
			return encodedData.map { try! JSONDecoder().decode(Article.self, from: $0) }
		}
		set {
			let data = newValue.map { try? JSONEncoder().encode($0) }
			UserDefaults.standard.set(data, forKey: UserDefaultsKeys.postsArrayKey.rawValue)
		}
	}
	
}


