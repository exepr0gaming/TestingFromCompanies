//
//  UserDefaultsService.swift
//  anonymNetworkTesting
//
//  Created by Курдин Андрей on 02.06.2021.
//

import Foundation

public final class UserDefaultsService {
	
	// MARK: - Public properties
	
	static let shared = UserDefaultsService()
	
	var nextPageCursor: String {
		get { UserDefaults.standard.string(forKey: UserDefaultsKeys.nextPageCursorKey.rawValue) ?? "" }
		set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.nextPageCursorKey.rawValue) }
	}
	
	var postsArray: [Item] {
		get {
			guard let encodedData = UserDefaults.standard.array(forKey: UserDefaultsKeys.postsArrayKey.rawValue) as? [Data] else { return [] }
			return encodedData.map { try! JSONDecoder().decode(Item.self, from: $0) }
		}
		
		set {
			let data = newValue.map { try? JSONEncoder().encode($0) }
			UserDefaults.standard.set(data, forKey: UserDefaultsKeys.postsArrayKey.rawValue)
		}
	}
	
	var currentSortType: String {
		get {
			guard let sortTypeRawValue = UserDefaults.standard.string(forKey: UserDefaultsKeys.sortTypeKey.rawValue) else { return "notSorted" }
			return SortType(rawValue: sortTypeRawValue)!.rawValue
		}
		set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.sortTypeKey.rawValue) }
	}
	
	// MARK: - Private properties
	private enum UserDefaultsKeys: String {
		case nextPageCursorKey
		case postsArrayKey
		case sortTypeKey
	}
	
}
