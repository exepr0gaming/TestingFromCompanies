//
//  CellForNews.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class CellForNews: UITableViewCell {
	
	static let cellId = "UserPostCell"
	
	// MARK: - Private properties
//	private lazy var containerView: UIView = {
//		let view = UIView()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.clipsToBounds = true
//		return view
//	}()
	private lazy var authorLabel = UILabel(text: "authorLabel", textAlignment: .center, font: .font12())
	private lazy var titleLabel = UILabel(text: "titleLabel", textAlignment: .center, font: .titleFont())
	private lazy var descriptionLabel = UILabel(text: "descriptionLabel", textAlignment: .left)
	private lazy var articleImageView = UIImageView()
	private lazy var leftVstackView = UIStackView()
	private lazy var rightVstackView = UIStackView()
	private lazy var hstackView = UIStackView()
	
	// MARK: - Lifecycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	
		articleImageView.contentMode = .scaleAspectFit
		authorLabel.textColor = .systemGray
		authorLabel.numberOfLines = 2
		
		setupSubviews()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/// Setup Labels for the cell
	func setupCell(author: String, title: String, description: String, imageUrl: String) {
		DispatchQueue.main.async { [self] in
			authorLabel.text = author
			titleLabel.text = title
			descriptionLabel.text = description
		}
		DispatchQueue.global().async {
			guard let url = URL(string: imageUrl),
						let imageData = try? Data(contentsOf: url)
			else { return }
			DispatchQueue.main.async { [self] in
				articleImageView.image = UIImage(data: imageData)
			}
		}
	}
	
	private func setupSubviews() {
		[leftVstackView, rightVstackView, hstackView, authorLabel, titleLabel, descriptionLabel, articleImageView].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		leftVstackView = UIStackView(arrangedSubviews: [articleImageView, authorLabel], axis: .vertical, spacing: 8)
		rightVstackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel], axis: .vertical, spacing: 8)
		hstackView = UIStackView(arrangedSubviews: [leftVstackView, rightVstackView], axis: .horizontal, spacing: 8)
		hstackView.alignment = .top
		hstackView.distribution = .fill
		
		addSubview(hstackView)
	}
	
	private func setupConstraints() {
		articleImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		articleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		
				NSLayoutConstraint.activate([
					leftVstackView.widthAnchor.constraint(equalToConstant: 100),
					
					hstackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
					hstackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
					hstackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
					hstackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
				])
	}
	
}
