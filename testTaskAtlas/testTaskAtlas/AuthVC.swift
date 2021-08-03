//
//  AuthVC.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class AuthVC: UIViewController, UITextFieldDelegate {
	
	let welcomeLabel = UILabel(text: "Welcome back!", font: .font26())
	let fastLoginButton = UIButton(title: "Login with user/password", titleColor: .white, backgroundColor: .buttonBlack(), font: .font16(), isShadow: false, cornerRadius: 4)
	let loginLabel = UILabel(text: "Login")
	let passwordLabel = UILabel(text: "Password")
	
	let loginTextField = OneLineTextField(font: .font20())
	let passwordTextField = OneLineTextField(font: .font20())
	let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack())
	
	let scrollView = UIScrollView()
	var stackForViews = UIStackView()
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		passwordTextField.isSecureTextEntry = true
		
		setupViews()
		setupSubviewsAndConstraints()
		
		addTargetForCheckTextFields()
		
		loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		fastLoginButton.addTarget(self, action: #selector(fastLoginButtonTapped), for: .touchUpInside)
	}
	
	
	func addTargetForCheckTextFields() {
		enableOrDisLoginButton(false)
		loginTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),	for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
	}
	
	@objc func textFieldsIsNotEmpty(textfield: UITextField) {
		textfield.text = textfield.text?.trimmingCharacters(in: .whitespaces)
		guard	let login = loginTextField.text, !login.isEmpty,
					 let password = passwordTextField.text, !password.isEmpty
		else {
			enableOrDisLoginButton(false)
			return
		}
		enableOrDisLoginButton(true)
	}
	
	//	deinit {
	//		removeKeyboardNotification()
	//	}
	
	private func enableOrDisLoginButton(_ bool: Bool) {
		if bool {
			loginButton.isEnabled = true
			loginButton.alpha = 1
		} else {
			loginButton.isEnabled = false
			loginButton.alpha = 0.25
		}
	}
	
	private func setupViews() {
		let emailStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextField], axis: .vertical, spacing: 0)
		let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
		stackForViews = UIStackView(arrangedSubviews: [fastLoginButton, emailStackView, passwordStackView, loginButton], axis: .vertical,	spacing: 10)
	}
	
	@objc private func fastLoginButtonTapped() {
				let navC = UINavigationController(rootViewController: ContainerVC())
				navC.modalPresentationStyle = .fullScreen
				UserDefaultsService.shared.authCheck = true
				self.present(navC, animated: true, completion: nil)
	}
	
	@objc private func loginButtonTapped() {
		AuthService.shared.checkLoginAndPassword(login: loginTextField.text, password: passwordTextField.text) { result in
			switch result {
				case .success(_):
					DispatchQueue.main.async {
						self.showAlert(title: "Успешно", message: "Вы авторизованы") {
							let navC = UINavigationController(rootViewController: ContainerVC())
							navC.modalPresentationStyle = .fullScreen
							UserDefaultsService.shared.authCheck = true
							self.present(navC, animated: true, completion: nil)
						}
					}
				case .failure(let error):
					self.showAlert(title: "Ошибка", message: error.localizedDescription)
				case .none:
					print("Captain, does not understand why there is .none? But without him he gives err, strange")
			}
		}
	}
	
} // LoginViewController

// MARK: - Setup constraints
extension AuthVC {
	
	private func setupSubviewsAndConstraints() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		stackForViews.translatesAutoresizingMaskIntoConstraints = false
		
		scrollView.addSubview(welcomeLabel) // scroll view был, чтобы поднять на размер клавиатуры, но потом просто поднял TFs
		scrollView.addSubview(stackForViews)
		view.addSubview(scrollView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
		])
		
		loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		fastLoginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		NSLayoutConstraint.activate([
			//welcomeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 160),
			welcomeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			stackForViews.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 25),
			stackForViews.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -340),
			stackForViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			stackForViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
		])
		
	}
}

// MARK: - Keyboard Notifications
//extension LoginViewController {
//
//	func registerForKeyboardNotifications() {
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//	}
//
//	@objc func keyboardWillShow(_ notification: Notification) {
//		let userInfo = notification.userInfo
//		guard let kbFrameSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//		scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
//	}
//
//	@objc func keyboardWillHide(_ notification: Notification) {
//		scrollView.contentOffset = CGPoint.zero
//	}
//
//	private func removeKeyboardNotification() {
//		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//	}
//}

// MARK: - Show Alert
extension AuthVC {
	
	func showAlert(title: String, message: String, completion: @escaping () -> Void = { }) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
			completion()
		}
		alertController.addAction(okAction)
		present(alertController, animated: true, completion: nil)
	}
}

// MARK: - SwiftUI previews Canvas
//import SwiftUI
//struct LoginVCProvider: PreviewProvider {
//	static var previews: some View {	ContainerView().edgesIgnoringSafeArea(.all)	}
//	struct ContainerView: UIViewControllerRepresentable {
//		let viewController = LoginViewController()
//		func makeUIViewController(context: Context) -> some LoginViewController  { viewController	}
//		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context){}}}
