//
//  MenuCell.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 03.08.2021.
//

import UIKit

class MenuTableCell: UITableViewCell {
	
	static let reuseId = "MenuTableCell"
	
	let iconImageView: UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		iv.clipsToBounds = true
		
		return iv
	}()
	
	let myLabel = UILabel(text: "Text menu", textAlignment: .left, font: .font14(), numberOfLines: 1)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		addSubview(iconImageView)
		addSubview(myLabel)
		
		backgroundColor = .clear
		myLabel.textColor = .white
		iconImageView.tintColor = .white
		
		// iconImageView constaints
		iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
		iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
		
		// myLabel constaints
		myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		myLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

