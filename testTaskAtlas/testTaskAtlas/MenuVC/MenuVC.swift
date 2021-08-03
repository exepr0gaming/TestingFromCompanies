//
//  MenuVC.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 03.08.2021.
//

import UIKit

class MenuVC: UIViewController {
	
	var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
		configureTableView()
	}
	
	
	func configureTableView() {
		tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.reuseId)
		view.addSubview(tableView)
		tableView.frame = view.frame
		
		tableView.separatorStyle = .none
		tableView.rowHeight = 90
		tableView.backgroundColor = .darkGray
	}
	
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseId) as! MenuTableCell
		cell.iconImageView.image = UIImage(systemName: "filemenu.and.cursorarrow")
		cell.myLabel.text = "Logout \(indexPath.row)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

			let ac = UIAlertController(title: nil, message: "Вы уверены что хотите выйти?", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
			ac.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { (_) in
				guard let key = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
				UserDefaultsService.shared.authCheck = false
				key.rootViewController = AuthVC()
			}))
			present(ac, animated: true, completion: nil)
	}

}

