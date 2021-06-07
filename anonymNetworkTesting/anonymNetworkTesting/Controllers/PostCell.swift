//
//  PostCell.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import UIKit

class PostCell: UITableViewCell {
	
	// MARK: - Public properties
	
	static let cellID = "PostCell"
	
	var testLabel: UILabel = {
		let label = UILabel()
		label.text = "testLabel"
		return label
	}()
	// MARK: - Private properties
	
	private lazy var contentLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.numberOfLines = 0
		label.textAlignment = .natural
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.7
		return label
	}()
	
	private lazy var dateLabel = UILabel()
	private lazy var authorLabel = UILabel()
	private lazy var likesLabel = UILabel()
	private lazy var viewsLabel = UILabel()
	private lazy var statsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = NSLayoutConstraint.Axis.horizontal
		stackView.alignment = .leading
		stackView.distribution = .equalCentering
		return stackView
	}()
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()
	
	// MARK: - Lifecycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubviews()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - Public methods
	
	/// Setup Labels for the cell
	func setupCell(date: String, author: String, contentType: [String], likes: Int, views: Int) {
		dateLabel.text = date
		authorLabel.text = author
		contentLabel.text = "Post contains:\n\(contentType))"
		likesLabel.text = "Likes: \(likes)"
		viewsLabel.text = "  Views: \(views)"
	}
	
	// MARK: - Private methods
	
	private func setupSubviews() {
		statsStackView = UIStackView(arrangedSubviews: [likesLabel, viewsLabel])
		
		statsStackView.translatesAutoresizingMaskIntoConstraints = false
		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		authorLabel.translatesAutoresizingMaskIntoConstraints = false
		likesLabel.translatesAutoresizingMaskIntoConstraints = false
		viewsLabel.translatesAutoresizingMaskIntoConstraints = false
		
		[contentLabel, dateLabel, authorLabel, statsStackView].forEach {
			containerView.addSubview($0)
		}
		contentView.addSubview(containerView)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
		])
		NSLayoutConstraint.activate([
			contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
		])
		NSLayoutConstraint.activate([
			statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			statsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
		])
		NSLayoutConstraint.activate([
			dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
		])
		NSLayoutConstraint.activate([
			authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			authorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12),
			authorLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
		])
	}
	
}
