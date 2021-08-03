//
//  NetworkService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import Foundation//

enum AuthError {
	case notFilled
	case passwordSixPlus
	case serverError
	case loginNotFound
	case loginOrPasswordError
}

extension AuthError: LocalizedError {
	
	var errorDescription: String? {
		switch self {
			case .notFilled:
				return NSLocalizedString("Заполните все поля", comment: "")
			case .passwordSixPlus:
				return NSLocalizedString("Пароль должен состоять из 6 и более символов", comment: "")
			case .serverError:
				return NSLocalizedString("Ошибка сервера", comment: "")
			case .loginNotFound:
				return NSLocalizedString("Пользователь с таким именем не найден", comment: "")
			case .loginOrPasswordError:
				return NSLocalizedString("Введён неверный Логин или Пароль", comment: "")
		}
	}
}

enum ErrorType: String, Error {
	case decodingError = "Could not decode JSON"
	case requestFailed = "The request failed, check your Internet connection"
	case invalidData = "The data is invalid"
}
