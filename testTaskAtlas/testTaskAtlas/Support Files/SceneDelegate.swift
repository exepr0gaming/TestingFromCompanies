//
//  SceneDelegate.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()
		
		if UserDefaultsService.shared.authCheck {
			window?.rootViewController = UINavigationController(rootViewController: ContainerVC())
		} else {
			window?.rootViewController = AuthVC()
		}
	}

}

