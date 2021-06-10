//
//  DetailViewController.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//
import UIKit

class DetailViewController: UIViewController {
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()
	private lazy var stackViewWithLabels = UIStackView()
	private lazy var titleLabel = UILabel(text: "titleLabel", textAlignment: .center, font: .titleFont())
	private lazy var bodyContentLabel = UILabel(text: "bodyContentLabel")
	private lazy var tableView: UITableView = {
		let tView = UITableView(frame: .zero, style: .plain)
		tView.dataSource = self
		tView.translatesAutoresizingMaskIntoConstraints = false
		//tView.rowHeight = 150
		tView.estimatedRowHeight = UITableView.automaticDimension
		tView.separatorStyle = .singleLine
		tView.tableFooterView = UIView()
		tView.keyboardDismissMode = .onDrag
		return tView
	}()
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	var alert: UIAlertController?
	var postId: Int?
	var userCommentsDataSource: [UserComments] = []
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	// MARK: - Public methods
	func setupTitleAndBody(title: String, bodyContent: String) {
		titleLabel.text = title
		bodyContentLabel.text = bodyContent
	}
	
	private func setupTableViewForComments() {
		tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellId)
	}
	
	// MARK: - Private methods
	private func setupView() {
		setupInitialData()
		setupTableViewForComments()
		setupStackViewAndSubView()
		setupConstraints()
		view.backgroundColor = .white
		navigationItem.title = "Post Details"
	} // setupView
	
	private func setupStackViewAndSubView() {
		stackViewWithLabels = UIStackView(arrangedSubviews: [titleLabel, bodyContentLabel])
		stackViewWithLabels.translatesAutoresizingMaskIntoConstraints = false
		stackViewWithLabels.axis = NSLayoutConstraint.Axis.vertical
		stackViewWithLabels.alignment = .leading
		stackViewWithLabels.distribution = .fillEqually
		
		containerView.addSubview(tableView)
		containerView.addSubview(stackViewWithLabels)
		view.addSubview(containerView)
	} // setupStackViewAndSubView
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
		])
		NSLayoutConstraint.activate([
			stackViewWithLabels.topAnchor.constraint(equalTo: containerView.topAnchor),
			stackViewWithLabels.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			stackViewWithLabels.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
		])
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: stackViewWithLabels.bottomAnchor, constant: 16),
			tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
	} // setupConstraints
	
	/// Set user comments data source from UserDefaults
	private func setupInitialData() {
		guard let postId = postId else { return }
		getComments(postId: postId)
	}
	
	func getComments(postId: Int) {
		self.activityIndicator.startAnimating()
		DispatchQueue.global().async {
			NetworkService.loadUserComments(url: Constants.defaultStringUrl, postId: postId) { result in
				switch result {
					case .success(let data):
						self.userCommentsDataSource = data
						DispatchQueue.main.async {
							self.activityIndicator.stopAnimating()
							self.tableView.reloadData()
						}
					case .failure(let error):
						DispatchQueue.main.async {
							self.activityIndicator.stopAnimating()
							self.showAlertController(message: error.rawValue, error: true)
						}
				}
			}
		}
	} // getComments
	
	// Prevent from showing multiple alert controllers
	func showAlertController(message: String? = nil, error: Bool) {
		guard alert == nil else { return }
		let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
			self.alert = nil
		}
		if error { alert = AlertService.showAlert(style: .alert, message: message, actions: [okAction])	}
		guard let alert = alert else { return }
		present(alert, animated: true, completion: nil)
	} // showAlertController
	
}

