//
//  UIImageView+Extension.swift
//  anonymNetworkTesting
//
//  Created by Курдин Андрей on 02.06.2021.
//

import UIKit

extension UIImageView {
		
		/// Load image from URL on background thread and update UI on main thread
		func load(url: URL) {
				let queue = DispatchQueue.global(qos: .utility)
				queue.async {
						if let data = try? Data(contentsOf: url) {
								DispatchQueue.main.async { [weak self] in
										self?.image = UIImage(data: data)
								}
						} else {
								DispatchQueue.main.async { [weak self] in
										self?.image = UIImage(systemName: "person")
								}
						}
				}
		}

}


