//
//  SupportingTest.swift
//  perminderTests
//  Tests the methods in the Supporting class.
//  According to Tyler, decode, writeToFile, and readFromJsonFile only work in the context of the simulator, as they deal with files stored on the computer, making it easier to test through manual testing. This will be documented in the testing documents.
//
//  Created by Leqi Shen on 2023-04-03.
//

@testable import perminder
import XCTest

final class SupportingTest: XCTestCase {
    
    var testBund:Bundle!
    
    override func setUp() {
        super.setUp()
        testBund = Bundle()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * tests "encode" function and compares it against swift's default JSON encoder
     */
    func testEncodeString() {
        let toBeEncoded = "Hello World!"
        let encodedString = testBund.encode(encode: toBeEncoded)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        let defaultEncodeString = try? encoder.encode(toBeEncoded)
        
        print(encodedString)
        XCTAssertEqual(encodedString, String(data: defaultEncodeString!, encoding: .utf8))
    }
    
    /**
     * tests "encode" function with int array, simulating RGB class, and compares it against swift's default encoder
     */
    func testEncodeRGB() {
        let toBeEncoded = [0, 100, 200] //uses int array to simulate RGB
        let encodedRGB = testBund.encode(encode: toBeEncoded)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        let defaultEncodeString = try? encoder.encode(toBeEncoded)
        
        print(encodedRGB)
        XCTAssertEqual(encodedRGB, String(data: defaultEncodeString!, encoding: .utf8))
    }
    
    func testFormatDate() {
        var components = DateComponents()
        components.minute = 10
        components.hour = 10
        components.day = 1
        components.month = 4
        components.year = 2023

        let date = Calendar.current.date(from: components)!
        
        XCTAssertEqual(formatDate(date: date), "01 Apr 2023 10:10")
    }
}
