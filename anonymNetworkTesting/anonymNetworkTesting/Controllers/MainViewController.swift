//
//  MainViewController.swift
//  anonymNetworkTesting
//
//  Created by admin on 02.06.2021.
//

import UIKit

class MainViewController: UIViewController {
	private var safeArea: UILayoutGuide!
	var alert: UIAlertController?
	var sortedBy: SortType?
	private var sortSelectionSegControl: UISegmentedControl = {
		let sControl = UISegmentedControl()
		sControl.selectedSegmentIndex = 0
		sControl.translatesAutoresizingMaskIntoConstraints = false
		sControl.frame.size.height = 50
		return sControl
	}()
	lazy var tableView: UITableView = {
		let tView = UITableView(frame: .zero, style: .plain)
		tView.rowHeight = 100
		tView.separatorStyle = .singleLine
		tView.tableFooterView = UIView()
		tView.translatesAutoresizingMaskIntoConstraints = false
		tView.keyboardDismissMode = .onDrag
		tView.dataSource = self
		tView.delegate = self
		return tView
	}()
	lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.hidesWhenStopped = true
		return indicator
	}()
	
	var postsDataSource: [Item] = [] {
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
		view.addSubview(sortSelectionSegControl)
		view.addSubview(activityIndicator)
		activityIndicator.center = view.center
		setupNavigationItem()
		setupSegmentedControl()
		loadControl()
		setupTableView()
	}
	
	/// Set data source and sort type from UserDefaults
	private func setupInitialData() {
		postsDataSource = UserDefaultsService.shared.postsArray
		sortedBy = SortType(rawValue: UserDefaultsService.shared.currentSortType)
	}
	
	/// Request posts If data source for tableView is empty
	private func performInitialPostsLoad() {
		if postsDataSource.isEmpty { getPosts() }
	}
	
	private func setupNavigationItem() {
		navigationItem.title = "Posts of a new employee of anonym.network"
	}
	
	private func setupSegmentedControl() {
		sortSelectionSegControl.selectedSegmentIndex = 0
		var index = 0
		for sortName in SortType.allCases {
			sortSelectionSegControl.insertSegment(withTitle: "\(sortName)", at: index, animated: false)
			index += 1
		}
		
		NSLayoutConstraint.activate([
			sortSelectionSegControl.widthAnchor.constraint(equalTo: view.widthAnchor),
			sortSelectionSegControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
			sortSelectionSegControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			sortSelectionSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func loadControl() {
		self.sortSelectionSegControl.addTarget(self, action: #selector(sortingSelectionSegControl(sender: )), for: .valueChanged)
	}
	
	@objc func sortingSelectionSegControl(sender: UISegmentedControl) {
		switch sortSelectionSegControl.selectedSegmentIndex {
			case 0:
				getPosts(sort: .notSorted)
				sortedBy = .notSorted
			case 1:
				getPosts(sort: .createdAt)
				sortedBy = .createdAt
			case 2:
				getPosts(sort: .mostPopular)
				sortedBy = .mostPopular
			case 3:
				getPosts(sort: .mostCommented)
				sortedBy = .mostCommented
			default:
				getPosts(sort: .notSorted)
				sortedBy = .notSorted
		}
		
		guard let sortedBy = sortedBy else { return }
		UserDefaultsService.shared.currentSortType = sortedBy.rawValue
		showAlertController(error: false)
		tableView.reloadData()
	}
	
	
	private func setupTableView() {
		tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellID)
		
		NSLayoutConstraint.activate(
			[
				tableView.topAnchor.constraint(equalTo: sortSelectionSegControl.bottomAnchor, constant: 0),
				tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			]
		)
	}
	
	func getPosts(sort: SortType? = nil, loadmore: Bool = false) {
		activityIndicator.startAnimating()
		
		NetworkService.loadItems(sort: sort, loadMore: loadmore) { result in
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
		
	}
	
}
