//
//  AlertService.swift
//  anonymNetworkTesting
//
//  Created by Курдин Андрей on 02.06.2021.
//

import UIKit

final class AlertService {
	
	static func showAlert(style: UIAlertController.Style, sortType: SortType?, message: String? = nil, actions: [UIAlertAction]) -> UIAlertController {
		
		let sortComment = "Data source has been loaded"
		var textMessage: String {
			guard let message = message else { return sortComment }
			return message
		}
		
		var title = ""
		
		switch sortType {
			case .notSorted:
				title = "Not sorted"
			case .mostPopular:
				title = "Sorted by popularity"
			case .mostCommented:
				title = "Sorted by number of comments"
			case .createdAt:
				title = "Sorted by creation date"
			case .none:
				title = "Error"
		}
		
		let alert = UIAlertController(title: title, message: textMessage, preferredStyle: style)
		actions.forEach { alert.addAction($0) }
		return alert
	}
}
