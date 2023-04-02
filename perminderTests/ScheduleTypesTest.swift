//
//  ScheduleTypesTest.swift
//  perminderTests
//  Includes testing for Timeblock, Day, Schedule, and Scheduletypes as they are all related
//
//  Created by Leqi Shen on 2023-04-01.
//

@testable import perminder
import XCTest

class ScheduleTypesTest: XCTestCase {
    
    var Block:Timeblock!
    var Block2:Timeblock!
    var CodableBlock:CodableTimeblock!
    let time1:String = "1010"
    let time2:String = "1515"
    let testTag:String = "Biology"
    let testTag2:String = "Homework"
    
    override func setUp() {
        Block = Timeblock(tA: time1)
        Block2 = Timeblock(tA: time2, tags:[testTag, testTag2])
        CodableBlock = CodableTimeblock(tags: [testTag, testTag2], time: time1)


        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeblockInit() {
        XCTAssertEqual(Block.timeAssigned, time1)
        XCTAssertEqual(Block2.timeAssigned, time2)
        XCTAssertEqual(Block2.groups, [testTag, testTag2])
    }
    
    func testCodableTimeblock() throws {
            // Encode the timeblock to JSON data
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(CodableBlock)
            
            // Decode the JSON data to a new timeblock object
            let decoder = JSONDecoder()
            let decodedTimeblock = try decoder.decode(CodableTimeblock.self, from: encodedData)
            
            // Ensure the decoded object is equal to the original object
            XCTAssertEqual(decodedTimeblock.tags, CodableBlock.tags)
            XCTAssertEqual(decodedTimeblock.time, CodableBlock.time)
    }

}
