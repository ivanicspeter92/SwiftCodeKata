//
//  CodeKataSwiftTests.swift
//  CodeKataSwiftTests
//
//  Created by Peter Ivanics on 14/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import XCTest
@testable import CodeKataSwift

class CodeKataSwiftTests: XCTestCase
{
    func testIterativeChop()
    {
        self.testKarateChop(IterativeKarateChopper());
    }
    
    func testRecursiveChop()
    {
        self.testKarateChop(RecursiveKarateChopper());
    }
    
    private func testKarateChop(chopper: KarateChopDelegate)
    {
        XCTAssertEqual(-1, chopper.chop(3, array: []))
        XCTAssertEqual(-1, chopper.chop(3, array: [1]))
        XCTAssertEqual(0,  chopper.chop(1, array: [1]))
        
        XCTAssertEqual(0,  chopper.chop(1, array: [1, 3, 5]))
        XCTAssertEqual(1,  chopper.chop(3, array: [1, 3, 5]))
        XCTAssertEqual(2,  chopper.chop(5, array: [1, 3, 5]))
        XCTAssertEqual(-1, chopper.chop(0, array: [1, 3, 5]))
        XCTAssertEqual(-1, chopper.chop(2, array: [1, 3, 5]))
        XCTAssertEqual(-1, chopper.chop(4, array: [1, 3, 5]))
        XCTAssertEqual(-1, chopper.chop(6, array: [1, 3, 5]))
        
        XCTAssertEqual(0,  chopper.chop(1, array: [1, 3, 5, 7]))
        XCTAssertEqual(1,  chopper.chop(3, array: [1, 3, 5, 7]))
        XCTAssertEqual(2,  chopper.chop(5, array: [1, 3, 5, 7]))
        XCTAssertEqual(3,  chopper.chop(7, array: [1, 3, 5, 7]))
        XCTAssertEqual(-1, chopper.chop(0, array: [1, 3, 5, 7]))
        XCTAssertEqual(-1, chopper.chop(2, array: [1, 3, 5, 7]))
        XCTAssertEqual(-1, chopper.chop(4, array: [1, 3, 5, 7]))
        XCTAssertEqual(-1, chopper.chop(6, array: [1, 3, 5, 7]))
        XCTAssertEqual(-1, chopper.chop(8, array: [1, 3, 5, 7]))

    }
}
