//
//  anonymNetworkTestingTests.swift
//  anonymNetworkTestingTests
//
//  Created by Курдин Андрей on 04.06.2021.
//

import XCTest
@testable import anonymNetworkTesting

class anonymNetworkTestingTests: XCTestCase {
	
	var sut = MainViewController() // system under test
	
    override func setUpWithError() throws {
			
			//try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
			
			
			//try? super.tearDownWithError()
    }

	func testTableViewNotNilWhenViewIsLoaded(){
		sut.loadViewIfNeeded()
		XCTAssertNotNil(sut.tableView)
	}
	
	//When View is Loaded Table View
	func testWViLTVDelegateAndDatasourceIsSetAndEquals() {
		XCTAssertTrue(sut.tableView.delegate is MainViewController)
		XCTAssertTrue(sut.tableView.dataSource is MainViewController)
		XCTAssertEqual(
			sut.tableView.delegate as? MainViewController,
			sut.tableView.dataSource as? MainViewController)
	}

}
