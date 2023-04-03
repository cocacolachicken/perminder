//
//  TagDatabaseTest.swift
//  perminderTests
//  Tests the TagDatabase class
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

    /**
     * Called at the start of testing by swift
     */
    override func setUp() {
        super.setUp()
        testDB = TagDatabase()
        tag1 = CodableTag(name: nameInTest, color: colorInTest)
        
    }

    /**
     * called at the end of testing
     */
    override func tearDown() {
        
        super.tearDown()
    }
    
    //tests adding a tag to the testDB
    func testAdd() {
        testDB.add(t: tag1)
        XCTAssertEqual(testDB.tags[nameInTest]?.getName(), nameInTest)
    }
    
    //tests creating a new tag through the testDB object
    func testCreateNew() {
        let tag2 = testDB.createNew(n:nameInTest, c:colorInTest)
        XCTAssertEqual(testDB.tags[nameInTest]?.getName(), tag1.name)
    }
}
