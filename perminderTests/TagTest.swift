//
//  TagTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-03.
//
@testable import perminder
import XCTest

final class TagTest: XCTestCase {
    
    let testName:String = "Biology"
    let testName2:String = "Chemistry"
    
    var testTag1:Tag!
    var testTag2:Tag!
    var testTag3:Tag!

    override func setUp() {
        super.setUp()

        testTag1 = Tag(n: testName, c: [0, 255, 100])
        testTag2 = Tag(n: testName, c: [0, 255, 100])
        testTag3 = Tag(n: testName2, c: [100, 255, 0])

    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testTagHash() {
        //creates 2 hashers to compare
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        
        //uses the hash implementation in Tag to hash name and color attributes
        testTag1.hash(into: &hasher1)
        testTag2.hash(into: &hasher2)
        //compares
        XCTAssertEqual(hasher1.finalize(), hasher2.finalize())
        
        hasher1 = Hasher()
        hasher2 = Hasher()
        testTag1.hash(into: &hasher1)
        testTag3.hash(into: &hasher2)
        //different tag attributes should not be equal after hashing
        XCTAssertNotEqual(hasher1.finalize(), hasher2.finalize())
        
    }
    
    func testTagEqualsImplementation() {
        
        //two identical tag names/colors should return true
        XCTAssertTrue(testTag1 == testTag2)
       
        //two different names/colors returns false
        XCTAssertFalse(testTag1 == testTag3)
    }
    
}
