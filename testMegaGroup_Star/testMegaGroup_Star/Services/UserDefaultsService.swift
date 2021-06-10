//
//  UserDefaultsShared.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
import Foundation

public final class UserDefaultsService {
	
	static let shared = UserDefaultsService()
	
	var nextPageNumber: String {
		get { UserDefaults.standard.string(forKey: UserDefaultsKeys.nextPageNumber.rawValue) ?? "1" }
		set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.nextPageNumber.rawValue) }
	}
	
	var postsArray: [User] {
		get {
			guard let encodedData = UserDefaults.standard.array(forKey: UserDefaultsKeys.postsArrayKey.rawValue) as? [Data] else { return [] }
			return encodedData.map { try! JSONDecoder().decode(User.self, from: $0) }
		}
		set {
			let data = newValue.map { try? JSONEncoder().encode($0) }
			UserDefaults.standard.set(data, forKey: UserDefaultsKeys.postsArrayKey.rawValue)
		}
	}
	
}

