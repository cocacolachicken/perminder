//
//  NotifTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-02.
//

@testable import perminder
import XCTest
import UserNotifications

final class NotifTest: XCTestCase {
    
    var notificationCenter: UNUserNotificationCenter!
    var testNotif:NotificationHandler!
    let id = "test"
    let title = "Biology"
    let body = "poster"
    let day = "Friday"
    let time = "1010"
    

    override func setUp() {
        notificationCenter = UNUserNotificationCenter.current()
        testNotif = NotificationHandler(Identifier: id, titleIn: title, bodyIn: body, dayIn: day, timeIn: time, centerIn: notificationCenter)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    

    func testCheckPermissionAuthorized() {
        // Create an expectation
        let expectation = self.expectation(description: "Notification permission authorized")
        // Use notification center to retrieve the current permission
        notificationCenter.getNotificationSettings { settings in
            // If the current status is not authorized, fulfill the expectation and return
            if settings.authorizationStatus != .authorized {
                expectation.fulfill()
                return
            }
            // If the current status is authorized, calls NotificationHandler
            let isAllowed = self.testNotif.checkPermission()
            // Assert that the returned value is true and fulfills expectation
            XCTAssertTrue(isAllowed)
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled or fail after 5 seconds
        wait(for: [expectation], timeout: 5)
    }
    
    func testCheckPermissionDenied() {
        let expectation = self.expectation(description: "Notification permission denied")
        notificationCenter.getNotificationSettings { settings in
            // If the current status is authorized, fulfill the expectation and return
            if settings.authorizationStatus == .authorized {
                expectation.fulfill()
                return
            }
            // If the current status is not authorized, calls NotificationHandler
            let isAllowed = self.testNotif.checkPermission()
            XCTAssertFalse(isAllowed)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
