//
//  ReminderTest.swift
//  perminderTests
//  Tests the Reminder class
//
//  Created by Leqi Shen on 2023-04-02.
//

@testable import perminder
import XCTest

final class ReminderTest: XCTestCase {
    
    //arbitrary testing values
    let testName:String = "Biology"
    let testName2:String = "Chemistry"
    
    var testReminder1:Reminder!
    var testReminder2:Reminder!
    var testReminder3:Reminder!

    var tag1String:String!
    var tag2String:String!
    
    /**
     * Called at the start of testing by swift
     */
    override func setUp() {
        super.setUp()
        tag1String = "Homework"
        tag2String = "Urgent"
        testReminder1 = Reminder(n: testName, c: Date(), d: nil, f: nil, tg: [tag1String], i: 0)
        testReminder2 = Reminder(n: testName, c: Date(), d: nil, f: nil, tg: [tag1String], i: 0)
        testReminder3 = Reminder(n: testName2, c: Date(), d: nil, f: nil, tg: [tag2String], i: 1)
    }

    /**
     * called at the end of testing
     */
    override func tearDown() {
        super.tearDown()
    }
    
    //Tests the hashing of the rids
    func testHash() {
        //creates 2 hashers to compare
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        
        //uses the hash implementation in reminder to hash name and rid attributes
        testReminder1.hash(into: &hasher1)
        testReminder2.hash(into: &hasher2)
        //compares
        XCTAssertEqual(hasher1.finalize(), hasher2.finalize())
        
        hasher1 = Hasher()
        hasher2 = Hasher()
        testReminder1.hash(into: &hasher1)
        testReminder3.hash(into: &hasher2)
        //different reminder attributes should not be equal after hashing
        XCTAssertNotEqual(hasher1.finalize(), hasher2.finalize())
        
    }
    
    //Tests the implementation of == as per hashable to compare the rids
    func testEqualsImplementation() {
        
        //two identical reminder rids should return true
        XCTAssertTrue(testReminder1 == testReminder2)
       
        //two different rids returns false
        XCTAssertFalse(testReminder1 == testReminder3)
    }
    
}
