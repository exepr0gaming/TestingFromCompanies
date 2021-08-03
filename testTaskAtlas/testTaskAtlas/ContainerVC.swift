//
//  ContainerVC.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 03.08.2021.
//

import UIKit

class ContainerVC: UIViewController {
	
	var newsVC: UIViewController!
	var menuVC: UIViewController!
	var isMove = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
		configureNewsVC()
	}
	
	private func setupNavigationBar() {
		navigationController?.setNavigationBarHidden(false, animated: false)
		let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
		navigationBar.backgroundColor = .blue
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(openMenu))
		navigationItem.rightBarButtonItem?.image = UIImage(systemName: "list.bullet")
		
		navigationItem.title = "Posts of the future employee of Atlas"
		view.addSubview(navigationBar)
	}
	
	@objc private func openMenu() {
		toggleMenu()
	}
	
	func configureNewsVC() {
		newsVC = NewsVC()
		addChild(newsVC)
		view.addSubview(newsVC.view)
		newsVC.didMove(toParent: self)
	}
	
	func configureMenuVC() {
		menuVC = MenuVC()
		addChild(menuVC)
		view.insertSubview(menuVC.view, at: 0)
		menuVC.didMove(toParent: self)
	}
	
	func showmenuVC(shouldMove: Bool) {
		if shouldMove {
			// показываем menu
			UIView.animate(withDuration: 0.5,
										 delay: 0,
										 usingSpringWithDamping: 0.8,
										 initialSpringVelocity: 0,
										 options: .curveEaseInOut,
										 animations: {
											self.newsVC.view.frame.origin.x = self.newsVC.view.frame.width - 140
										 }) { (finished) in
				
			}
		} else {
			// убираем menu
			UIView.animate(withDuration: 0.5,
										 delay: 0,
										 usingSpringWithDamping: 0.8,
										 initialSpringVelocity: 0,
										 options: .curveEaseInOut,
										 animations: {
											self.newsVC.view.frame.origin.x = 0
										 }) { (finished) in
				self.menuVC.remove()
			}
		}
	}
	
	func toggleMenu() {
		
		if !isMove {
			configureMenuVC()
		}
		isMove = !isMove
		showmenuVC(shouldMove: isMove)
	}
	
}


extension UIViewController {
//	func add(_ child: UIViewController) {
//		addChild(child)
//		view.addSubview(child.view)
//		child.didMove(toParent: self)
//	}
	
	func remove() {
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
}

