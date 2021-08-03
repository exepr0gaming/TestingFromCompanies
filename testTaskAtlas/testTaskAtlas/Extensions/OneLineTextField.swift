import UIKit

class OneLineTextField: UITextField {
	
	convenience init(font: UIFont? = .font20()) {
		self.init()
		
		self.font = font
		self.borderStyle = .none
		self.translatesAutoresizingMaskIntoConstraints = false
		self.autocapitalizationType = .none
		
		var bottomView = UIView()
		bottomView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		bottomView.backgroundColor = .textFieldLight()
		bottomView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(bottomView)
		
		NSLayoutConstraint.activate([
			bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			bottomView.heightAnchor.constraint(equalToConstant: 1)
		])
	}
	
}
