//
//  DetailViewController+Extension.swift
//  testMegaGroup_Star
//
//  Created by Курдин Андрей on 10.06.2021.
//
import UIKit

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		userCommentsDataSource.isEmpty ? 1 : userCommentsDataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if !userCommentsDataSource.isEmpty {
			let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellId, for: indexPath) as! CommentCell
			let comment = userCommentsDataSource[indexPath.row]
			self.postId = indexPath.row
			cell.setupCommentCell(email: comment.email, name: comment.name, body: comment.body)
			return cell
		} else {
			let defaultCell = UITableViewCell()
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
				defaultCell.textLabel?.text = "there should be comments, but something went wrong"
			})
			return defaultCell
		}
	} // ConfigureCell
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
} // UITableViewDataSource

