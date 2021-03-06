//
//  SceneDelegate.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
			guard let windowScene = (scene as? UIWindowScene) else { return }
			window = UIWindow(frame: UIScreen.main.bounds)

			let rootViewController = MainViewController()
			let navigationController = UINavigationController(rootViewController: rootViewController)
			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
			window?.windowScene = windowScene
	}

}

