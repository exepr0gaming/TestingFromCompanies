//
//  AnonymNetworkJSON.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import Foundation

// MARK: - AnonymNetworkModel
struct AnonymNetworkJSON: Codable {
	let data: AnonymNetworkJSONData
}

// MARK: - AnonymNetworkModelData
struct AnonymNetworkJSONData: Codable {
	let items: [Item]
	let cursor: String?
}

// MARK: - Item
struct Item: Codable {
	let id: String
	let type: ItemType
	let contents: [Content]
	let createdAt: Int
	let author: Author
	let stats: Stats
}

// MARK: - Author
struct Author: Codable {
	let name: String
	let photo: Photo?
}

// MARK: - Photo
struct Photo: Codable {
	let type: BannerType
	let id: String
	let data: PhotoData
}

// MARK: - PhotoData
struct PhotoData: Codable {
	let extraSmall: ExtraSmall
}

// MARK: - ExtraSmall
struct ExtraSmall: Codable {
	let url: String
	let size: Size
}

// MARK: - Size
struct Size: Codable {
	let width, height: Int
}

enum BannerType: String, Codable {
	case audio = "AUDIO"
	case image = "IMAGE"
	case imageGIF = "IMAGE_GIF"
	case tags = "TAGS"
	case text = "TEXT"
	case video = "VIDEO"
}

// MARK: - Content
struct Content: Codable {
	let data: ContentData
	let type: BannerType
	let id: String?
}

// MARK: - ContentData
struct ContentData: Codable {
	let value: String?
	let extraSmall, small: ExtraSmall?
	let url: String?
	let size: Size?
}

// MARK: - Stats
struct Stats: Codable {
	let likes, views: Comments
}

// MARK: - Comments
struct Comments: Codable {
	let count: Int
}

enum ItemType: String, Codable {
	case audioCover = "AUDIO_COVER"
	case plain = "PLAIN"
	case plainCover = "PLAIN_COVER"
	case video = "VIDEO"
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
	
	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}
	
	func hash(into hasher: inout Hasher) {}
	
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}

