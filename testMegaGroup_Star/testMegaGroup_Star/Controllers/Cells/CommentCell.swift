//
//  CommentCell.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 10.06.2021.
//
import UIKit

class CommentCell: UITableViewCell {
	
	static let cellId = "CommentCell"
	
	// MARK: - Private properties
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()
	private lazy var commentEmailLabel = UILabel(text: "commentEmailLabel")
	private lazy var commentNameLabel = UILabel(text: "commentNameLabel")
	private lazy var commentBodyLabel = UILabel(text: "commentBodyLabel")
	private lazy var stackViewWithComments = UIStackView()
	
	// MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupSubView()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - Public methods
	
	/// Setup Labels for the cell
	func setupCommentCell(email: String, name: String, body: String) {
		commentEmailLabel.text = email
		commentNameLabel.text = name
		commentBodyLabel.text = body
	}
	
	// MARK: - Private methods
	private func setupSubView() {
		[commentEmailLabel, commentNameLabel, commentBodyLabel].forEach {
			containerView.addSubview($0)
		}
		contentView.addSubview(containerView)
	} // setupStackViewAndSubView
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			containerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		NSLayoutConstraint.activate([
			commentEmailLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
			//	commentEmailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			commentEmailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			commentEmailLabel.bottomAnchor.constraint(equalTo: commentNameLabel.topAnchor)
		])
		NSLayoutConstraint.activate([
			commentNameLabel.topAnchor.constraint(equalTo: commentEmailLabel.bottomAnchor),
			commentNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			commentNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			commentNameLabel.bottomAnchor.constraint(equalTo: commentBodyLabel.topAnchor)
		])
		NSLayoutConstraint.activate([
			commentBodyLabel.topAnchor.constraint(equalTo: commentNameLabel.bottomAnchor),
			commentBodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			commentBodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			commentBodyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
	} // setupConstraints
	
}


