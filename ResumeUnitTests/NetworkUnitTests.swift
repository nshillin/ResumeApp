//
//  NetworkUnitTests.swift
//  ResumeUnitTests
//
//  Created by Noah Shillington on 2019-07-09.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit
import XCTest
@testable import Resume

class NetworkUnitTests: XCTestCase {
    
    var networkHandler:NetworkHandler!
    
    let invalidJSONURL = Bundle.main.url(forResource: "Invalid", withExtension: "json")
    let validJSONURL = Bundle.main.url(forResource: "Valid", withExtension: "json")
    let badURL = URL(string: "http://www.example.com:8800")

    override func setUp() {
        networkHandler = NetworkHandler()
    }
    
    func testInvalidURL() {
        let networkError = sendNetworkRequest(url: nil) as? NetworkError
        XCTAssertEqual(networkError, NetworkError.invalidURL)
    }
    
    func testBadURL() {
        let networkError = sendNetworkRequest(url: badURL) as? NetworkError
        XCTAssertEqual(networkError, NetworkError.defaultError)
    }
    
    func testInvalidJSON() {
        let networkError = sendNetworkRequest(url: invalidJSONURL) as? NetworkError
        XCTAssertEqual(networkError, NetworkError.invalidJSON)
    }
    
    func testValidJSON() {
        let profile = sendNetworkRequest(url: validJSONURL) as? Profile
        let networkError = sendNetworkRequest(url: invalidJSONURL) as? NetworkError
        XCTAssert(profile != nil, networkError?.message ?? "An unknown error occurred.")
    }
    
    func testValidDefault() {
        var userProfile:Profile?
        var networkError:NetworkError?
        let expectation = self.expectation(description: "NetworkCall")
        networkHandler.getDefaultUserProfile(success: { (profile) in
            userProfile = profile
            expectation.fulfill()
        }, failure: { (error) in
            networkError = error
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(userProfile != nil, networkError?.message ?? "An unknown error occurred.")
    }
    
    func sendNetworkRequest(url:URL?) -> Any? {
        var object:Any?
        let expectation = self.expectation(description: "NetworkCall")
        networkHandler.getProfile(profileURL: url, success: { (profile) in
            object = profile
            expectation.fulfill()
        }) { (error) in
            object = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        return object
    }
}
