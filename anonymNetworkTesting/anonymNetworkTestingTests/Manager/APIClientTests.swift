//
//  APIClientTests.swift
//  anonymNetworkTestingTests
//
//  Created by Курдин Андрей on 05.06.2021.
//

import XCTest
@testable import anonymNetworkTesting

class APIClientTests: XCTestCase {
	
	var sut: NetworkService!
	var mockURLSession: MockURLSession!
	let defaultURL = "https://k8s-stage.apianon.ru/posts/v1/posts"
	//var result: Result<Data, Error>?
	var result: ((Result<[Item], ErrorType>?) -> ())?
	var array: [Item]?
	var newArray: [String]?
	
	override func setUpWithError() throws {
		mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
		sut = NetworkService()
		sut.urlSession = mockURLSession
	}
	
	override func tearDownWithError() throws {
		
	}
	
	func testNetworkService() {
		sut.urlSession = mockURLSession
		guard let result = result else { return }
		sut.loadItems(completion: result)
		
		XCTAssertEqual(mockURLSession.urlComponents?.host, defaultURL)
	}
	
//	func testJsonInvalidReturnsError() {
//		//let jsonDataStub = "\(defaultURL)?orderBy=mostPopular".data(using: .utf8)
//		mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
//		sut.urlSession = mockURLSession
//		var caughtError: ErrorType?
//		let errorExp = expectation(description: "Error expectation")
//		guard let result = result else { return }
//		sut.loadItems(sort: .none, loadMore: false) { result in
//
//			caughtError = error as ErrorType
//			errorExp.fulfill()
//		}
//		waitForExpectations(timeout: 1) { _ in
//			XCTAssertNil(caughtError)
//		}
//		//		XCTAssertEqual(array?.count, 22)
//		//		XCTAssertEqual(newArray?.first, "p:bd2eVisE1l2qweqwe")
//
//	}

}

extension APIClientTests {
	class MockURLSession: URLSessionProtocol {
		
		var url: URL?
		private let mockDataTask: MockURLSessionDataTask
		var urlComponents: URLComponents? {
			guard let url = url else {
				return nil
			}
			return URLComponents(url: url, resolvingAgainstBaseURL: true)
		}
		
		var inputRequest: URLRequest?
		var executeCalled = false
		
		init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
			mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
		}
		
		func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
			self.url = url
			executeCalled = true
			//return URLSession.shared.dataTask(with: url)
			mockDataTask.completionHandler = completionHandler
			
			//result.map(completionHandler)
			return mockDataTask
		}
	}
	
	class MockURLSessionDataTask: URLSessionDataTask {
		private let data: Data?
		private let urlResponse: URLResponse?
		private let responseError: Error?
		
		typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
		var completionHandler: CompletionHandler?
		
		init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
			self.data = data
			self.urlResponse = urlResponse
			self.responseError = responseError
		}
		override func resume() {
			DispatchQueue.main.async {
				self.completionHandler?(
					self.data,
					self.urlResponse,
					self.responseError
				)
			}
		}
	}
}
