//
//  testNetworkTests.swift
//  testNetworkTests
//
//  Created by Jáir Myree on 6/7/21.
//

import XCTest
import DVR
import OHHTTPStubs
import OHHTTPStubsSwift

class testNetworkTests: XCTestCase {

    private var testSession = URLSession.shared
    private var testUrl = URL.init(string: "https://api.publicapis.org/entries")
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    //Uses DVR to simulate request
    func testDVRExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "Got 200 response")
        
        let session = Session(cassetteName: "example")
        session.dataTask(with: self.testUrl!) { data, response, error in
            
        
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200)
                print("DVR Response: \(httpResponse.statusCode)")
                expectation.fulfill()
            }
        }.resume()
        
        wait(for: [expectation], timeout: 10.0)
    }

    //Uses OHTTPSStubs to simulate request
    func testStubExample() throws {
        stub(condition: isHost(testUrl!.host!)) { _ in
            let path = Bundle(for: Self.self).path(forResource: "example", ofType: "json")
            return fixture(filePath: path!, status: 200, headers: nil)
        }
    
        let expectation = XCTestExpectation(description: "Got 200 response")
        
        testSession.dataTask(with: self.testUrl!) { data, response, error in
            
        
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200)
                print("DVR Response: \(httpResponse.statusCode)")
                expectation.fulfill()
            }
        }.resume()
        
        wait(for: [expectation], timeout: 10.0)
    }

}
