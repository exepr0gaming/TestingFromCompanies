//
//  UILabel+Extension.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//
import UIKit

extension UILabel {
	
	convenience init(text: String = "textLabel", textAlignment: NSTextAlignment = .left, font: UIFont = .textFont()) {
		self.init()
		self.text = text
		self.textAlignment = textAlignment
		self.font = font
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.numberOfLines = 0
		self.sizeToFit()
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.75
	}
	
}

