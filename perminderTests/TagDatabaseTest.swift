//
//  TagDatabaseTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-02.
//

@testable import perminder
import XCTest

final class TagDatabaseTest: XCTestCase {
    
    let nameInTest = "Biology"
    let colorInTest:[Int] = [0, 255, 100]
    
    var testDB:TagDatabase!
    var tag1:CodableTag!

    override func setUp() {
        super.setUp()
        testDB = TagDatabase()
        tag1 = CodableTag(name: nameInTest, color: colorInTest)
        
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func testAdd() {
        testDB.add(t: tag1)
        XCTAssertEqual(testDB.tags[nameInTest]?.getName(), nameInTest)
    }
    
    func testCreateNew() {
        let tag2 = testDB.createNew(n:nameInTest, c:colorInTest)
        XCTAssertEqual(testDB.tags[nameInTest]?.getName(), tag1.name)
    }
}
