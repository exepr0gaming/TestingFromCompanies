//
//  AuthService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class AuthService {
	static let shared = AuthService()
	private var alert: UIAlertController?
	let authLoginName = "user"
	let authLoginPassword = "password"
	var authorization = ""
	
	func checkLoginAndPassword(login: String?, password: String?, completion: @escaping (Result<Login, Error>?) -> Void) {
		guard Validators.isFilledLogin(login: login, password: password) else {
			completion(.failure(AuthError.notFilled))
			return }
		if !Validators.passwordMinSixChars(password: password) {
			completion(.failure(AuthError.passwordSixPlus))
		}
		if login != authLoginName  {
			completion(.failure(AuthError.loginNotFound))
		}
		if password != authLoginPassword {
			completion(.failure(AuthError.loginOrPasswordError))
		}
		if login == authLoginName && password == authLoginPassword {
			getAuthResponse(login: login!, password: password!, auth: true) { _ in  // response in
				completion(.success(Login(user: login!, authenticated: true)))
			}
		}
		getAuthResponse(login: login!, password: password!, auth: false) { response in
			completion(.failure(AuthError.loginOrPasswordError))
		}
	}
	
	func getAuthResponse(login: String, password: String, auth: Bool, completion: @escaping (Login?) -> Void) {
		let serverStringForAuth = "https://httpbin.org/basic-auth/\(login)/\(password)"
		guard let url = URL(string: serverStringForAuth) else { return }
		
		let configuration = URLSessionConfiguration.default
		configuration.urlCredentialStorage = nil
		
		let session = URLSession(configuration: configuration)
		
		let loginString = "\(login):\(password)"
		
		guard let loginData = loginString.data(using: String.Encoding.utf8) else {
			return
		}
		
		let base64LoginString = loginData.base64EncodedString()
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		auth == true ? (authorization = "Authorization") : (authorization = "")
		
		request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: authorization)
		
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				print(error.localizedDescription)
			}
			if let data = data {
				if let currentResponse = self.parseJson(data: data) {
					completion(currentResponse)
				}
			}
		}.resume()
	}
	
	func parseJson(data: Data) -> Login? {
		do {
			let jsonResponse = try JSONDecoder().decode(Login.self, from: data)
			return jsonResponse
		} catch let error as NSError {
			print(String(describing: error))
		}
		return nil
	}
	
	
	
	func buttonWithLoginNameAndPass(completion: @escaping (Login?) -> Void) {
		completion((Login(user: authLoginName, authenticated: true)))
	}
	
}

