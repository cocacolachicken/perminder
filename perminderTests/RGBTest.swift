//
//  RGBTest.swift
//  perminderTests
//  Tests the RBG class and object
//
//  Created by Leqi Shen on 2023-04-01.
//

@testable import perminder
import XCTest

class RGBTest: XCTestCase {

    //initializes variables and arbitrary test values
    var RGBTest:RGB!
    var RGBTest2:RGB!
    var RGBTest3:RGB!
    let testRed = 255
    let testGreen = 145
    let testBlue = 35
    
    /**
     * Called at the start of testing by swift
     */
    override func setUp() {
        super.setUp()
        //Sets the values for the 3 RGB values. 2 are identical and one is different
        RGBTest = RGB(red: testRed, green: testGreen, blue: testBlue)
        RGBTest2 = RGB(red: testRed, green: testGreen, blue: testBlue)
        RGBTest3 = RGB(red: 0, green: 0, blue: 0)

    }

    /**
     * called at the end of testing
     */
    override func tearDown() {
        
        super.tearDown()
    }
    
    //tests the equality between different RGB values
    func testRGBEquality() {
        XCTAssertEqual(RGBTest, RGBTest2)
        XCTAssertNotEqual(RGBTest, RGBTest3)
    }
    
    //Tests the hashing of RGB values and the equality between different RGB objects after hashing
    func testRGBHash() {
        XCTAssertEqual(RGBTest.hashValue, RGBTest2.hashValue)
        XCTAssertNotEqual(RGBTest.hashValue, RGBTest3.hashValue)
    }
    
    //Tests if the initialized values in RGB are the same as the ones passed in
    func testRGBInitialization() {
        XCTAssertEqual(RGBTest.r, testRed)
        XCTAssertEqual(RGBTest.g, testGreen)
        XCTAssertEqual(RGBTest.b, testBlue)
    }
    
    //Tests creating an array from the RGB object's method and compares it to a normal array made from the testing values
    func testRGBToArray() {
        XCTAssertEqual(RGBTest.toArray(), [testRed, testGreen, testBlue])
    }
    
}

