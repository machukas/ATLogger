//
//  ATLoggerTests.swift
//  ATLoggerTests
//
//  Created by Nicolas Landa on 8/5/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import XCTest
@testable import ATLogger

class ATLoggerTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldWrite() {
		let infoLogger = ATLogger(withLevel: .info)
		let releaseLogger = ATLogger(withLevel: .error, mode: .release)
		
		XCTAssert(infoLogger.shouldWrite(inSeverityLevel: .info, evenInReleaseMode: false))
		
		XCTAssert(!infoLogger.shouldWrite(inSeverityLevel: .debug, evenInReleaseMode: false))
		
		XCTAssert(!releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: false))
		
		XCTAssert(releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: true))
    }
	
	func testWriteFormat() {
		let infoLogger = ATLogger(withLevel: .info)
		
		infoLogger.log(.info, "testWriteFormat")
		var output = infoLogger.formatOutput(text: "testWriteFormat", sourceFile: "ATLoggerTests.swift", functionName: "testWriteFormat()", lineNumber: 40)

		let range = output.startIndex..<output.index(output.startIndex, offsetBy: 20)
		output.removeSubrange(range) // Quitar la fecha
		
		let testOutput = "[INFO] ATLoggerTests.swift->testWriteFormat() [#40]| testWriteFormat"
		
		XCTAssert(testOutput == output)
	}
}
