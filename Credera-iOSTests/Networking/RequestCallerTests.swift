//
//  RequestCallerTests.swift
//  Credera-iOSTests
//
//  Created by Fernando Berrios on 3/16/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import XCTest
//import OHHTTPStubs
import Promises

class RequestCallerTests: XCTestCase {
    
    private static let TEST_HOST = "test.example.com"
    private static let BASE_URL = "https://\(TEST_HOST)"
    
    private struct TestCodable: Codable {}
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        OHHTTPStubs.removeAllStubs()
    }
    
    func test_callForDecodable_withInvalidJson_correctErrorIsReturned() {
        
        // Arrange
        let testExpectation = expectation(description: "test_callForDecodable_withInvalidJson_correctErrorIsReturned")
        
        stub(condition: isHost(RequestCallerTests.TEST_HOST)) { _ in
            let stubData = "Hello World!".data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode: 200, headers: nil)
        };
        
        let request = HttpRequest(httpMethod: HttpMethod.get, path: "", baseUrl: RequestCallerTests.BASE_URL)
        let caller = RequestCaller()
        
        // Act
        let promise: Promise<TestCodable> = caller.call(request)
        
        // Assert
        promise.then { value in
            // Nothing to test here
        }.catch({ error in
            XCTAssertEqual(NetworkError.DecodeJson, error as! NetworkError)
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10)
    }
    
    func test_callForDecodable_withResponseOf404_correctErrorIsReturned() {
        
        // Arrange
        let testExpectation = expectation(description: "test_callForDecodable_withResponseOf404_correctErrorIsReturned")
        
        stub(condition: isHost(RequestCallerTests.TEST_HOST)) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
        };
        
        let request = HttpRequest(httpMethod: HttpMethod.post, path: "", baseUrl: RequestCallerTests.BASE_URL)
        let caller = RequestCaller()
        
        // Act
        let promise: Promise<TestCodable> = caller.call(request)
        
        // Assert
        promise.then { value in
            // Nothing to test here
        }.catch({ error in
            XCTAssertEqual(HttpError.NotFound, error as! HttpError)
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10)
    }
    
    func test_callForDecodable_withResponseOf500_correctErrorIsReturned() {
        
        // Arrange
        let testExpectation = expectation(description: "test_callForDecodable_withResponseOf500_correctErrorIsReturned")
        
        stub(condition: isHost(RequestCallerTests.TEST_HOST)) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 500, headers: nil)
        };
        
        let request = HttpRequest(httpMethod: HttpMethod.options, path: "", baseUrl: RequestCallerTests.BASE_URL)
        let caller = RequestCaller()
        
        // Act
        let promise: Promise<TestCodable> = caller.call(request)
        
        // Assert
        promise.then { value in
            // Nothing to test here
            }.catch({ error in
                XCTAssertEqual(HttpError.InternalServerError, error as! HttpError)
                testExpectation.fulfill()
            })
        
        waitForExpectations(timeout: 10)
    }
    
    func test_callForDecodable_withInvalidStatusCode_correctErrorIsReturned() {
        
        // Arrange
        let testExpectation = expectation(description: "test_callForDecodable_withInvalidStatusCode_correctErrorIsReturned")
        
        stub(condition: isHost(RequestCallerTests.TEST_HOST)) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 666, headers: nil)
        };
        
        let request = HttpRequest(httpMethod: HttpMethod.put, path: "", baseUrl: RequestCallerTests.BASE_URL)
        let caller = RequestCaller()
        
        // Act
        let promise: Promise<TestCodable> = caller.call(request)
        
        // Assert
        promise.then { value in
            // Nothing to test here
        }.catch({ error in
            XCTAssertEqual(NetworkError.Unknown, error as! NetworkError)
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10)
    }
    
    func test_callForDecodable_withInvalidRequest_correctErrorIsReturned() {
        
        // Arrange
        let testExpectation = expectation(description: "test_callForDecodable_withInvalidRequest_correctErrorIsReturned")
    
        let request = HttpRequest(httpMethod: HttpMethod.put, path: "", baseUrl: "ssh://user:password@url.com")
        let caller = RequestCaller()
        
        // Act
        let promise: Promise<TestCodable> = caller.call(request)
        
        // Assert
        promise.then { value in
            // Nothing to test here
            }.catch({ error in
                XCTAssertEqual(NetworkError.InvalidRequest, error as! NetworkError)
                testExpectation.fulfill()
            })
        
        waitForExpectations(timeout: 10)
    }
}
