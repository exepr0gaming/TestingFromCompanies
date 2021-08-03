import UIKit

extension UILabel {
	
	convenience init(text: String = "textLabel", textAlignment: NSTextAlignment = .left, font: UIFont = .font16(), numberOfLines: Int = 0) {
		self.init()
		self.text = text
		self.textAlignment = textAlignment
		self.font = font
		self.textColor = textColor
		self.translatesAutoresizingMaskIntoConstraints = false
		self.numberOfLines = numberOfLines
		self.minimumScaleFactor = 0.75
	}
	
}
