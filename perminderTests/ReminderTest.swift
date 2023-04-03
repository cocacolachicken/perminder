//
//  ReminderTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-02.
//

@testable import perminder
import XCTest

final class ReminderTest: XCTestCase {
    
    let testName:String = "Biology"
    
    var testReminder1:Reminder!
    var testReminder2:Reminder!
    var tag1:Tag!

    override func setUp() {
        super.setUp()
        tag1 = Tag(n: "Homework", c: [0, 255, 100])
        testReminder1 = Reminder(n: testName, c: Date(), d: nil, f: nil, tg: [tag1], i: 0)
        testReminder2 = Reminder(n: testName)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testHash() {
       
    }
    
    
    
}
