import XCTest
import UIKit
import Conekta

class ConektaTests: XCTestCase {
    
    func testGetToken() {
        let expectation = self.expectation(description: "collect")
        
        let conekta = Conekta(publicKey: "")!
        
        let card = Card(number: "4111111111111111", name: "test", cvc: "111", month: "11", year: "2020")
        conekta.collectDevice(view: UIView())
        conekta.getToken(for: card) { (token, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(token)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testInvalidCard() {
        let expectation = self.expectation(description: "invalid")
        
        guard let conekta = Conekta(publicKey: "") else {
            XCTFail()
            return
        }
        let card = Card(number: "4000000000000002", name: "test", cvc: "111", month: "11", year: "2020")
        conekta.collectDevice(view: UIView())
        conekta.getToken(for: card) { (token, error) in
            XCTAssertNil(token)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 4.0)
    }


    static var allTests = [
        ("testExample", testGetToken),
    ]
}
