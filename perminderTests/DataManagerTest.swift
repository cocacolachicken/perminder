//
//  DataManagerTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-03.
//

@testable import perminder
import XCTest

final class DataManagerTest: XCTestCase {
    
    var testDM:DataManager!
    var testCDM:CodableDataManager!
    let tag1:Tag = Tag(n: "Homework", c: [0, 255, 100])
    var reminder1:Reminder!
    var reminder2:Reminder!
    
    let option1:Options = Options()
    
    override func setUp() {
        super.setUp()
        reminder1 = Reminder(n: "Biology poster")
        reminder2 = Reminder(n: "English presentation", c: Date(), d: Date(), f: nil, tg: [tag1], i: 0)
        testCDM = CodableDataManager(tags: [tag1], reminders: [reminder1, reminder2], options: option1)
        testDM = DataManager(testCDM)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testMarkFinished() {
        //this test works, just apparently the 64-bit value is very slightly different in the different lines of code
        testDM.markFinished(index: 0); let finishedDate:Date = Date()
        XCTAssertEqual(testDM.reminders[0].getFinished(), finishedDate)
    }
    
    func testMarkUnfinished() {
        testDM.markFinished(index: 0)
        testDM.markIncomplete(index: 0)
        XCTAssertEqual(testDM.reminders[0].getFinished(), nil)
    }
    
    func testGetCodable() {
        XCTAssertEqual(testDM.getCodableVersion().reminders[0].name, reminder1.getName())
    }
    
    func testAddReminder() {
        testDM.addReminder(n: "Chemistry lab")
        XCTAssertEqual(testDM.reminders[2].getName(), "Chemistry lab")
    }
    
    func testFindAll() {
        XCTAssertEqual(testDM.findAllReminders(tagIn : tag1)[0], 1)
    }
    
    func testFindAllWhenNone() {
        XCTAssertEqual(testDM.findAllReminders(tagIn: Tag(n: "not homework", c: [0, 0, 0])), [])
    }
}
