//
//  MainViewController.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//

import UIKit

class MainViewController: UIViewController {
	private var safeArea: UILayoutGuide!
	private var alert: UIAlertController?
	private lazy var tableView: UITableView = {
		let tView = UITableView(frame: .zero, style: .plain)
		tView.dataSource = self
		tView.delegate = self
		tView.translatesAutoresizingMaskIntoConstraints = false
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
	
	var pageNumber = 1
	var postsDataSource: [User] = [] {
		didSet { UserDefaultsService.shared.postsArray = postsDataSource }
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		performInitialPostsLoad()
	}
	
	// MARK: - Private methods
	private func setupView() {
		setupInitialData()
		safeArea = view.layoutMarginsGuide
		view.backgroundColor = .white
		view.addSubview(tableView)
		view.addSubview(activityIndicator)
		activityIndicator.center = view.center
		setupNavigationItem()
		setupTableView()
	}
	
	/// Set data source and sort type from UserDefaults
	private func setupInitialData() {
		postsDataSource = UserDefaultsService.shared.postsArray
	}
	
	/// Request posts If data source for tableView is empty
	private func performInitialPostsLoad() {
		if postsDataSource.isEmpty { getPosts(loadmore: false) }
	}
	
	private func setupNavigationItem() {
		navigationItem.title = "Posts of the future employee of MegaGroup"
	}
	
	private func setupTableView() {
		tableView.register(UserPostCell.self, forCellReuseIdentifier: UserPostCell.cellId)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func getPosts(loadmore: Bool = false) {
		activityIndicator.startAnimating()
		NetworkService.loadUserPosts(url: Constants.defaultStringUrl, pageNumber: pageNumber, loadMore: loadmore) { result in
			switch result {
				case .success(let data):
					if loadmore {
						self.postsDataSource.append(contentsOf: data)
					} else {
						self.postsDataSource = data
					}
					DispatchQueue.main.async {
						self.activityIndicator.stopAnimating()
						self.tableView.reloadData()
					}
				case .failure(let error):
					print("--- Сaptain, our ship is sinking, error: \(error.rawValue)")
					DispatchQueue.main.async {
						self.activityIndicator.stopAnimating()
						self.showAlertController(message: error.rawValue, error: true)
					}
			}
		}
	} // getPosts
	
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
	
} // Main

