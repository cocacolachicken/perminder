//
//  RGBTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-01.
//

@testable import perminder
import XCTest

class RGBTest: XCTestCase {

    var RGBTest:RGB!
    
    override func setUp() {
        super.setUp()
        RGBTest = RGB(red: 255, green: 145, blue: 35)
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func testRGBToArray() {
        XCTAssertEqual(RGBTest.toArray(), [100, 150, 200])
    }
        
    func testRGBInitialization() {
        XCTAssertEqual(RGBTest.r, 255)
        XCTAssertEqual(RGBTest.g, 0)
        XCTAssertEqual(RGBTest.b, 128)
    }
}

