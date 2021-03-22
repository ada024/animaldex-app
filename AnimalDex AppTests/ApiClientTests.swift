//
//  ApiClientTests.swift
//  AnimalDex AppTests
//
//  Created by Andreas M. (ada024) on 22/03/2021.
//

import XCTest
@testable import AnimalDex_App

class ApiClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTrainers() {
        let expect = expectation(description: "fetch trainers")
        ApiClient().getTrainers() {(result: Result<[Trainer], Error>) in
            expect.fulfill()
            switch result {
            case .success(let trainers):
              XCTAssertNotNil(trainers)
              XCTAssertEqual(trainers.count, 3)
            case .failure:
              XCTFail()
            }
          }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
