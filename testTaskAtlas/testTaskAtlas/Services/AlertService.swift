//
//  NetworkService.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

final class AlertService: UIViewController {
	
	static func showAlert(style: UIAlertController.Style, message: String? = nil, actions: [UIAlertAction]) -> UIAlertController {
		let loadComment = "Данные загружены"
		var textMessage: String {
			guard let message = message else { return loadComment }
			return message
		}
		let title = ""
		let alert = UIAlertController(title: title, message: textMessage, preferredStyle: style)
		actions.forEach { alert.addAction($0) }
		return alert
	}
	
}

