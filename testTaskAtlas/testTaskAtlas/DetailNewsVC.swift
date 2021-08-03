//
//  DetailNewsVC.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class DetailNewsVC: UIViewController {
	
	private lazy var stackView = UIStackView()
	private lazy var titleLabel = UILabel(text: "titleLabel", textAlignment: .center, font: .titleFont())
	private lazy var contentLabel = UILabel(text: "descriptionLabel", textAlignment: .left)
	private lazy var articleImageView = UIImageView()
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		articleImageView.contentMode = .scaleAspectFit
		setupStackViewAndSubView()
		setupConstraints()
	
	}
	
	// MARK: - Public methods
	func setupDetailVC(imageUrl: String, title: String, content: String) {
		titleLabel.text = title
		contentLabel.text = content
		DispatchQueue.global().async {
			guard let url = URL(string: imageUrl),
						let imageData = try? Data(contentsOf: url)
			else { return }
			DispatchQueue.main.async { [self] in
				articleImageView.image = UIImage(data: imageData)
			}
		}
	}
	
	
	// MARK: - Private methods
	private func setupView() {
		view.backgroundColor = .white
		navigationItem.title = "Post Details"
	} // setupView
	
	private func setupStackViewAndSubView() {
		stackView = UIStackView(arrangedSubviews: [articleImageView, titleLabel, contentLabel], axis: .vertical, spacing: 10)
		articleImageView.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
	} // setupStackViewAndSubView
	
	private func setupConstraints() {
		
		NSLayoutConstraint.activate([
			articleImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
			
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
		])
	
	} // setupConstraints
	
}
