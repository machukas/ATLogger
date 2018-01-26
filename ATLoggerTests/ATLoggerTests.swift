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
		let debugLogger = ATLogger(withLevel: .debug)
		let infoLogger = ATLogger(withLevel: .info)
		let noticeLogger = ATLogger(withLevel: .notice)
		let warningLogger = ATLogger(withLevel: .warning)
		let errorLogger = ATLogger(withLevel: .error)
		let releaseLogger = ATLogger(withLevel: .error, mode: .release, showLevel: false, showFileNames: false, showLineNumbers: false)
		
		debugLogger.debug("")
		infoLogger.info("")
		noticeLogger.notice("")
		warningLogger.warning("")
		errorLogger.error("")
		
		releaseLogger.log("")
		
		XCTAssert(infoLogger.shouldWrite(inSeverityLevel: .info, evenInReleaseMode: false))
		
		XCTAssert(!infoLogger.shouldWrite(inSeverityLevel: .debug, evenInReleaseMode: false))
		
		XCTAssert(!releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: false))
		
		XCTAssert(releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: true))
    }
	
	func testWriteFormat() {
		let infoLogger = ATLogger(withLevel: .info)
		
		infoLogger.info("testWriteFormat")
		var output = infoLogger.formatOutput(text: "testWriteFormat", sourceFile: "ATLoggerTests.swift", functionName: "testWriteFormat", lineNumber: 40)

		let range = output.startIndex..<output.index(output.startIndex, offsetBy: 20)
		output.removeSubrange(range) // Quitar la fecha
		let testOutput = "[INFO] [testWriteFormat] [ATLoggerTests.swift:40]| testWriteFormat"
		
		XCTAssert(testOutput == output)
	}
	
	func testAPIs() {
		
	}
}
