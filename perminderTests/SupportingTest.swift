//
//  SupportingTest.swift
//  perminderTests
//
//  Created by Leqi Shen on 2023-04-03.
//

@testable import perminder
import XCTest

final class SupportingTest: XCTestCase {
    func testDecodeValidFile() {
        // Given
        let jsonString = """
            {
                "name": "Acme Inc.",
                "founded": "2000-01-01T00:00:00Z",
                "employees": 100
            }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let fileManager = FileManager.default
        let temporaryDirectory = fileManager.temporaryDirectory
        let filePath = temporaryDirectory.appendingPathComponent("test.json")
        try! jsonData.write(to: filePath)
        
        let testBund:Bundle = Bundle()
        let result = try! testBund.decode(file: filePath.path) as String
        
        // Then
        let expected: String =
                    """
                        {
                            "name": "Acme Inc.",
                            "founded": "2000-01-01T00:00:00Z",
                            "employees": 100
                        }
                    """
        XCTAssertEqual(result, expected)
    }
}
