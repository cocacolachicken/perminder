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
    let tag1 = Tag(n: "Homework", c: [0, 255, 100])
    let tag1String:String = "Homework"
    var reminder1:Reminder!
    var reminder2:Reminder!
    
    let option1:Options = Options()
    
    /**
     * Called at the start of testing by swift
     */
    override func setUp() {
        super.setUp()
        reminder1 = Reminder(n: "Biology poster")
        reminder2 = Reminder(n: "English presentation", c: Date(), d: Date(), f: nil, tg: [tag1String], i: 0)
        testCDM = CodableDataManager(tags: [tag1], reminders: [reminder1, reminder2], options: option1)
        testDM = DataManager(testCDM)
    }
    
    /**
     * called at the end of testing
     */
    override func tearDown() {
        super.tearDown()
    }

    /**
     * Tests marking a reminder as finished with the current time
     */
    func testMarkFinished() {
        testDM.markFinished(index: 0); let finishedDate:String = formatDate(date: Date())
        XCTAssertEqual(formatDate(date: testDM.reminders[0].getFinished()!), finishedDate)
    }
    
    /**
     * Tests marking a reminder as unfinished with nil
     */
    func testMarkUnfinished() {
        testDM.markFinished(index: 0)
        testDM.markIncomplete(index: 0)
        XCTAssertEqual(testDM.reminders[0].getFinished(), nil)
    }
    
    /**
     * Tests getting  the codable version of the datamanager
     */
    func testGetCodable() {
        XCTAssertEqual(testDM.getCodableVersion().reminders[0].name, reminder1.getName())
    }
    
    /**
     * Tests adding a new reminder into the array of reminders
     */
    func testAddReminder() {
        testDM.addReminder(n: "Chemistry lab")
        XCTAssertEqual(testDM.reminders[2].getName(), "Chemistry lab")
    }
    
    /**
     * Test finding all reminders with a specified tag
     */
    func testFindAll() {
        XCTAssertEqual(testDM.findAllReminders(tagIn : tag1String)[0], 1)
    }
    
    /**
     * Tests finding all reminders when there's no reminders with the tag
     */
    func testFindAllWhenNone() {
        XCTAssertEqual(testDM.findAllReminders(tagIn: "not homework"), [])
    }
}
