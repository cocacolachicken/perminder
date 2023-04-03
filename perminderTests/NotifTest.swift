//
//  NotifTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-02.
//

@testable import perminder
import XCTest

final class NotifTest: XCTestCase {
    
    var notificationCenter: UNUserNotificationCenter!
    var testNotif:NotificationHandler!

    override func setUp() {
        notificationCenter = UNUserNotificationCenter.current()
        //testNotif = NotificationHandler(Identifier: <#T##String#>, titleIn: <#T##String#>, bodyIn: <#T##String#>, dayIn: <#T##String#>, timeIn: <#T##String#>, centerIn: notificationCenter)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /**
    func testCheckPermission_authorized() {
            let expectation = self.expectation(description: "Notification permission authorized")
            notificationCenter.getNotificationSettings { settings in
                if settings.authorizationStatus != .authorized {
                    expectation.fulfill()
                    return
                }
                let isAllowed = Notification.checkPermission()
                XCTAssertTrue(isAllowed)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5)
        }
     */
}
