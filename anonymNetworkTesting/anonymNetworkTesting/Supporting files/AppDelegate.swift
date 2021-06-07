//
//  AppDelegate.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			return true
		}

		// MARK: UISceneSession Lifecycle
		func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
				UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
		}
}



