//
//  ErrorType.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//
import Foundation

enum ErrorType: String, Error {
	case decodingError = "Could not decode JSON"
	case requestFailed = "The request failed, check your Internet connection"
	case invalidData = "The data is invalid"
}
