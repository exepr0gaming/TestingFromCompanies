//
//  Cell.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//
import UIKit

class UserPostCell: UITableViewCell {
	
	static let cellId = "UserPostCell"
	
	// MARK: - Private properties
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()
	private lazy var titleLabel = UILabel(text: "titleLabel", textAlignment: .left, font: .titleFont())
	private lazy var bodyContentLabel = UILabel(text: "bodyContentLabel", textAlignment: .left)
	
	// MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubviews()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/// Setup Labels for the cell
	func setupCell(title: String, bodyContent: String) {
		titleLabel.text = title
		bodyContentLabel.text = bodyContent
	}
	
	private func setupSubviews() {
		[titleLabel, bodyContentLabel].forEach {
			containerView.addSubview($0)
		}
		contentView.addSubview(containerView)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			containerView.heightAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor)
		])
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
		])
		NSLayoutConstraint.activate([
			bodyContentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			bodyContentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			bodyContentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
			bodyContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
	}
	
}
