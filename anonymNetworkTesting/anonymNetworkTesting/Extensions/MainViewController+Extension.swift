//
//  MainViewController+Extension.swift
//  anonymNetworkTesting
//
//  Created by Курдин Андрей on 04.06.2021.
//

import UIKit

// MARK: - UITableViewDataSource

extension MainViewController {
	
	func showAlertController(message: String? = nil, error: Bool) {
	 // Prevent from showing multiple alert controllers
	 guard alert == nil else { return }

	 let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
		 self.alert = nil
	 }
	 if error {
		 alert = AlertService.showAlert(style: .alert, sortType: nil, message: message, actions: [okAction])
	 } else {
		 guard let sortedBy = sortedBy else { return }
		 alert = AlertService.showAlert(style: .alert, sortType: sortedBy, message: message, actions: [okAction])
	 }
	 guard let alert = alert else { return }
	 present(alert, animated: true, completion: nil)
 }
	
	/// Convert date from UNIX to Date
	private func convertDate(value: Int, short: Bool) -> String {
		let date = Date.init(timeIntervalSince1970: TimeInterval(value / 1000))
		let dateFormatter = DateFormatter()
		if short == true {
			dateFormatter.timeStyle = DateFormatter.Style.short
			dateFormatter.dateStyle = DateFormatter.Style.short
		} else if short == false {
			dateFormatter.dateFormat = "HH:mm E, d MMM y"
		}
		dateFormatter.timeZone = .current
		let localDate = dateFormatter.string(from: date)
		return localDate
	}
	
	private func findContentText(in content: [Content]) -> String? {
		for element in content {
			if element.type == .text {
				return element.data.value
			}
		}
		return ""
	}
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		postsDataSource.isEmpty ? 1 : postsDataSource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if !postsDataSource.isEmpty {
			let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.cellID, for: indexPath) as! PostCell
			let post = postsDataSource[indexPath.row]

			var arrayOfContent: [String] = []
			let postContent = post.contents
			for content in postContent {
				arrayOfContent.append(content.type.rawValue)
			}

			cell.setupCell(date: convertDate(value: post.createdAt, short: true),
										 author: post.author.name,
										 contentType: arrayOfContent,
										 likes: post.stats.likes.count,
										 views: post.stats.views.count)
			return cell
		} else {
			let defaultCell = UITableViewCell()
			defaultCell.textLabel?.text = "No data to display"
			return defaultCell
		}
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// Load more posts when scrolling down
		if indexPath.row == postsDataSource.count - 1 {
			getPosts(sort: sortedBy, loadmore: true)
		}
	}
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		let post = postsDataSource[indexPath.row]
		let authorImageStringUrl = post.author.photo?.data.extraSmall.url
		let webViewUrl = post.contents.last?.data.small?.url

		detailVC.setupVC(dateString: "Created at: " + convertDate(value: post.createdAt, short: false),
										 authorName: "Author name: " + "\(post.author.name)",
										 authorImageUrl: authorImageStringUrl,
									 contentText: findContentText(in: post.contents),
									 webViewUrl: webViewUrl ?? "")

		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}
