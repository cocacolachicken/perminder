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
    var RGBTest2:RGB!
    var RGBTest3:RGB!
    let testRed = 255
    let testGreen = 145
    let testBlue = 35
    
    override func setUp() {
        super.setUp()
        RGBTest = RGB(red: testRed, green: testGreen, blue: testBlue)
        RGBTest2 = RGB(red: testRed, green: testGreen, blue: testBlue)
        RGBTest3 = RGB(red: 0, green: 0, blue: 0)

    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func testRGBEquality() {
        XCTAssertEqual(RGBTest, RGBTest2)
        XCTAssertNotEqual(RGBTest, RGBTest3)
    }
    
    func testRGBHash() {
        XCTAssertEqual(RGBTest.hashValue, RGBTest2.hashValue)
        XCTAssertNotEqual(RGBTest.hashValue, RGBTest3.hashValue)
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

