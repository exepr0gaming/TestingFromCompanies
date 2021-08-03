//
//  AuthViewController.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 31.07.2021.
//

import UIKit

class NewsVC: UIViewController {
	
	private var alert: UIAlertController?
	private lazy var tableView = UITableView()
	let refreshControlForTV: UIRefreshControl = {
		let rc = UIRefreshControl()
		rc.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		return rc
	}()
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	var pageNumber = 1
	var postsDataSource: [Article] = [] {
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
		view.backgroundColor = .white
		setupTableView()
		
		view.addSubview(activityIndicator)
		activityIndicator.center = view.center
	}
	
	@objc private func refresh(sender: UIRefreshControl) {
		pageNumber += 1
		DispatchQueue.main.async {
			self.getNews(loadmore: false)
			self.tableView.reloadData()
			sender.endRefreshing()
		}
	}
	
	/// Set data source from UserDefaults
	private func setupInitialData() {
		postsDataSource = UserDefaultsService.shared.postsArray
	}
	
	/// Request posts If data source for tableView is empty
	private func performInitialPostsLoad() {
		if postsDataSource.isEmpty { getNews(loadmore: false) }
	}
	
	private func setupTableView() {
		tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = 150 // UITableView.automaticDimension
		tableView.separatorStyle = .singleLine
		tableView.tableFooterView = UIView()
		tableView.keyboardDismissMode = .onDrag
		tableView.refreshControl = refreshControlForTV
		
		tableView.register(CellForNews.self, forCellReuseIdentifier: CellForNews.cellId)
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func getNews(loadmore: Bool = false) {
		activityIndicator.startAnimating()
		NetworkService.shared.loadItems(pageNumber: pageNumber, loadMore: loadmore) { result in
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


// MARK: - UITableViewDataSource
extension NewsVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		postsDataSource.isEmpty ? 1 : postsDataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if !postsDataSource.isEmpty {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellForNews.cellId, for: indexPath) as! CellForNews
			let post = postsDataSource[indexPath.row]
			cell.setupCell(author: post.author, title: post.title, description: post.description, imageUrl: post.urlToImage ?? "")
			return cell
		} else {
			let defaultCell = UITableViewCell()
			defaultCell.textLabel?.text = "Что нужно, чтобы всегда писать хороший код? Представляйте себе, что читать и саппортить ваш продукт будет маньяк-убийца, которому кто-то сказал, где вы живете."
			return defaultCell
		}
	} // ConfigureCell
	
	// Load more posts when scrolling down
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let lastVisibleindexPath = tableView.indexPathsForVisibleRows?.last {
			if indexPath.row == postsDataSource.count - 1 && indexPath ==  lastVisibleindexPath {
				pageNumber += 1
				getNews(loadmore: true)
			}
		}
	}
	
} // UITableViewDataSource

// MARK: - UITableViewDelegate
extension NewsVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = DetailNewsVC()
		let post = postsDataSource[indexPath.row]
		detailVC.setupDetailVC(imageUrl: post.urlToImage ?? "", title: post.title, content: post.content)
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
} // UITableViewDelegate

