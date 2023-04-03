//
//  ScheduleTypesTest.swift
//  perminderTests
//  Includes testing for Timeblock, Day, Schedule, Scheduletypes, and Options as they are all related
//
//  Created by Leqi Shen on 2023-04-01.
//

@testable import perminder
import XCTest

class SchedulingClassesTest: XCTestCase {
    
    //Timeblock
    var Block:Timeblock!
    var Block2:Timeblock!
    var CodableBlock:CodableTimeblock!
    var CodableBlock2:CodableTimeblock!
    let time1:String = "1010"
    let time2:String = "1515"
    let testDayIndex = 0
    let testScheduleType:String = "Weekly"
    
    //Day
    var day1:Day!
    var codableDay1:CodableDay!
    var codableDay2:CodableDay!

    //Schedule
    var codableSchedule1:CodableSchedule!
    
    override func setUp() {
        //Timeblock
        Block = Timeblock(tA: time1)
        Block2 = Timeblock(tA: time2)
        CodableBlock = CodableTimeblock(time: time1)
        CodableBlock2 = CodableTimeblock(time: time1)

        //Day
        day1 = Day(i: testDayIndex)
        codableDay1 = CodableDay()
        codableDay2 = CodableDay(blocks: [CodableBlock, CodableBlock2])

        //Schedule
        codableSchedule1 = CodableSchedule(days: [codableDay2], type: testScheduleType)

        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeblockInit() {
        XCTAssertEqual(Block.timeAssigned, time1)
        XCTAssertEqual(Block2.timeAssigned, time2)
    }
    
    func testCodableTimeblockNoTags() throws {
        // Encodes timeblock to JSON
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(CodableBlock)
        
        // Decodes JSON to new timeblock object
        let decoder = JSONDecoder()
        let decodedTimeblock = try decoder.decode(CodableTimeblock.self, from: encodedData)
        
        // Ensure the decoded object is equal to original values
        XCTAssertEqual(decodedTimeblock.time, CodableBlock.time)
    }
    
    func testCodableTimeblockWithTags() throws {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(CodableBlock2)
        
        let decoder = JSONDecoder()
        let decodedTimeblock = try decoder.decode(CodableTimeblock.self, from: encodedData)
        
        XCTAssertEqual(decodedTimeblock.time, CodableBlock2.time)
    }

    
    func testAddTimeToDay() {
        day1.addTimeBlock(time: time1)
        XCTAssertEqual(day1.times[0].timeAssigned, Block.timeAssigned)
    }
    
    func testDeleteTime() {
        day1.addTimeBlock(time: time1)
        day1.addTimeBlock(time: time2)
        day1.deleteTime(index: (day1.times.count)-1)
        XCTAssertEqual(day1.times[(day1.times.count)-1].timeAssigned, Block.timeAssigned)
    }

    func testGetTime() {
        day1.addTimeBlock(time: time2)
        XCTAssertEqual(day1.getTimes()[0].timeAssigned, Block2.timeAssigned)
    }
    
    func testCodableDayEmptyBlocks() throws {
        
        // Encodes day to JSON data
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(codableDay1)
        
        // Decodes the JSON
        let decoder = JSONDecoder()
        let decodedDay = try decoder.decode(CodableDay.self, from: encodedData)
        
        // Ensure the decoded object is identical to blank object
        XCTAssertIdentical(decodedDay.blocks as AnyObject, [CodableTimeblock]().self as AnyObject)
    }
    
    func testCodableDayWithBlocks() throws {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(codableDay2)
        
        let decoder = JSONDecoder()
        let decodedDay = try decoder.decode(CodableDay.self, from: encodedData)
        
        XCTAssertEqual(decodedDay.blocks.count, codableDay2.blocks.count)
        XCTAssertEqual(decodedDay.blocks[0].time, CodableBlock.time)
        XCTAssertEqual(decodedDay.blocks[1].time, CodableBlock2.time)
    }
    
    func testCodableSchedule() throws {
        
        // Encodes schedule to JSON
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(codableSchedule1)
        
        // Decodes JSON to new schedule object
        let decoder = JSONDecoder()
        let decodedSchedule = try decoder.decode(CodableSchedule.self, from: encodedData)
        
        // Ensure the decoded object is equal to the original object
        XCTAssertEqual(decodedSchedule.type, codableSchedule1.type)
        XCTAssertEqual(decodedSchedule.days.count, codableSchedule1.days.count)
        XCTAssertEqual(decodedSchedule.days[0].blocks.count, codableSchedule1.days[0].blocks.count)
        XCTAssertEqual(decodedSchedule.days[0].blocks[0].time, CodableBlock.time)
        XCTAssertEqual(decodedSchedule.days[0].blocks[1].time, CodableBlock2.time)
    }
    
    
    
}
