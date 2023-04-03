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

    override func setUp() {
        super.setUp()
        testReminder1 = Reminder(n: testName)
        testReminder2 = Reminder(n: testName)
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func testHash() {
       
    }
    
    
    
}
