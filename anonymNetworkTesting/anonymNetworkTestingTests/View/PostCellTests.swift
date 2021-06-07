//
//  PostCellTests.swift
//  anonymNetworkTestingTests
//
//  Created by Курдин Андрей on 07.06.2021.
//

import XCTest
@testable import anonymNetworkTesting

class PostCellTests: XCTestCase {

	let controller = MainViewController()
	var cell: PostCell! 
	
    override func setUpWithError() throws {
			controller.loadViewIfNeeded()
			let tableView = controller.tableView
			let dataSource = FakeDataSource()
			tableView.dataSource = dataSource
			cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: IndexPath(row: 0, section: 0 )) as? PostCell
    }
	
	func testCellHasContentLabel() {
		XCTAssertNil(cell.testLabel)
	}
	
	func testCellHasContentLabelInContentView() {
		XCTAssertTrue(cell.testLabel.isDescendant(of: cell.contentView))
	}

    

}

extension PostCellTests {
	class FakeDataSource: NSObject, UITableViewDataSource {
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			1
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			return UITableViewCell()
		}
		
		
	}
}
