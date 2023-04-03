//
//  NotifTest.swift
//  perminderTests
//  Tests the NotificationHandler test
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
    
    /**
     * Called at the start of testing by swift
     */
    override func setUp() {
        notificationCenter = UNUserNotificationCenter.current()
        testNotif = NotificationHandler(Identifier: id, titleIn: title, bodyIn: body, dayIn: day, timeIn: time, centerIn: notificationCenter)
        super.setUp()
    }

    /**
     * called at the end of testing
     */
    override func tearDown() {
        super.tearDown()
    }
    
    //Tests the handling of a situation when the authorization is given to send a notification
    func testCheckPermissionAuthorized() {
        // Create an expectation
        let expectation = self.expectation(description: "Notification permission authorized")
        // Use notification center to retrieve the current permission
        notificationCenter.getNotificationSettings { settings in
            // If the current status is not authorized, fulfill the expectation and return
            if settings.authorizationStatus == .authorized {
                expectation.fulfill()
                return
            }
            // If the current status is authorized, calls NotificationHandler
            let isAllowed = self.testNotif.checkPermission()
            // Assert that the returned value is true (Since permission is given)
            XCTAssertTrue(isAllowed)
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled or fail after 5 seconds
        wait(for: [expectation], timeout: 5)
    }
    
    //Tests the handling of a situation when the authorization is not given to send a notification
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
            // Assert that the returned is false (Since permission isn't given)
            XCTAssertFalse(isAllowed)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
