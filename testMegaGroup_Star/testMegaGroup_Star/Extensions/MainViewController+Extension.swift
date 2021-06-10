//
//  MainViewController+Extension.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 09.06.2021.
//
import UIKit

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		postsDataSource.isEmpty ? 1 : postsDataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if !postsDataSource.isEmpty {
			let cell = tableView.dequeueReusableCell(withIdentifier: UserPostCell.cellId, for: indexPath) as! UserPostCell
			let post = postsDataSource[indexPath.row]
			cell.setupCell(title: post.title, bodyContent: post.body)
			return cell
		} else {
			let defaultCell = UITableViewCell()
			defaultCell.textLabel?.text = "Hello boy (or girl)"
			return defaultCell
		}
	} // ConfigureCell
	
	// Load more posts when scrolling down
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let lastVisibleindexPath = tableView.indexPathsForVisibleRows?.last {
			if indexPath.row == postsDataSource.count - 1 && indexPath ==  lastVisibleindexPath {
				pageNumber += 1
				getPosts(loadmore: true)
			}
		}
	}
	
} // UITableViewDataSource

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		let post = postsDataSource[indexPath.row]
		detailVC.postId = post.id
		detailVC.setupTitleAndBody(title: post.title, bodyContent: post.body)
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
} // UITableViewDelegate

