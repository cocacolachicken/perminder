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
    let testRed = 255
    let testGreen = 145
    let testBlue = 35
    
    override func setUp() {
        super.setUp()
        RGBTest = RGB(red: testRed, green: testGreen, blue: testBlue)
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func testRGBInitialization() {
        XCTAssertEqual(RGBTest.r, testRed)
        XCTAssertEqual(RGBTest.g, testGreen)
        XCTAssertEqual(RGBTest.b, testBlue)
    }
    
    func testRGBToArray() {
        XCTAssertEqual(RGBTest.toArray(), [testRed, testGreen, testBlue])
    }
    
}

