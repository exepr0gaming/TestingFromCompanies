//
//  DetailViewController.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import UIKit

class DetailViewController: UIViewController {
	
	// MARK: - Private properties
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()
	
	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		return label
	}()
	
	private lazy var authorNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()
	
	private lazy var authorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
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
	
	private lazy var contentView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupSubviews()
		setupConstraints()
	}
	
	// MARK: - Public methods
	
	func setupVC(dateString: String, authorName: String, authorImageUrl: String?, contentText: String?, webViewUrl: String) {
		dateLabel.text = dateString
		authorNameLabel.text = authorName
		setupImageView(stringUrl: authorImageUrl, urlFor: .author)
		contentLabel.text = contentText
		setupImageView(stringUrl: webViewUrl, urlFor: .contentView)
	}
	
	// MARK: - Private methods
	
	private enum UrlFor {
		case author
		case contentView
	}
	
	private func setupImageView(stringUrl: String?, urlFor: UrlFor) {
		guard
			let contentString = stringUrl, contentString != "",
			let contentUrl = URL(string: contentString)
		else { return }
		switch urlFor {
			case .author:
				authorImageView.load(url: contentUrl)
			case .contentView:
				contentView.load(url: contentUrl)
		}
	}
	
	private func setupView() {
		view.backgroundColor = .white
		navigationItem.title = "Post Details"
	}
	
	private func setupSubviews() {
		[dateLabel, authorNameLabel, authorImageView, contentLabel, contentView].forEach {
			containerView.addSubview($0)
		}
		view.addSubview(containerView)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
			dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
			dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
			dateLabel.heightAnchor.constraint(equalToConstant: 16)
		])
		
		NSLayoutConstraint.activate([
			authorNameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
			authorNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
			authorNameLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
			authorNameLabel.heightAnchor.constraint(equalToConstant: 16)
		])
		
		NSLayoutConstraint.activate([
			authorImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
			authorImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			authorImageView.heightAnchor.constraint(equalToConstant: 100),
			authorImageView.widthAnchor.constraint(equalTo: authorImageView.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 30),
			contentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 160)
		])
		
		NSLayoutConstraint.activate([
			contentLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12),
			contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
			contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
		])
	}
	
}
