//
//  BowlingGameTests.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 30/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import XCTest
@testable import CodeKataSwift

/// Test cases for the BowlingGame class.
/// - seealso: BowlingGame.swift
class BowlingGameTests: XCTestCase
{
    // MARK: - Variables
    private var game: BowlingGame!;
    
    // MARK: - Initializers
    /**
     Initializes the game variable.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    override func setUp() {
        super.setUp();
        self.game = BowlingGame();
    }
    
    // MARK: - Test cases
    /**
     Test case for the BowlingGame when all rolls knock down 0 pins.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testGutterGame()
    {
        self.rollMany(20, pins: 0); // rolling 20 times all zeros
        XCTAssertEqual(self.game.score(), 0);
    }
    
    /**
     Test case for the BowlingGame when all rolls knock down 1 pins.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testAllOnes()
    {
        self.rollMany(20, pins: 1); // rolling 20 times all ones
        XCTAssertEqual(self.game.score(), 20);
    }
    
    /**
     Test case for the BowlingGame when the player scores one Spare in the first round.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testOneSpare()
    {
        self.rollSpare(); // spare - the value of the next roll counts as double
        self.game.roll(3); // should add 6 instead of 3
        self.rollMany(17, pins: 0);
        
        XCTAssertEqual(16, self.game.score());
    }
    
    /**
     Test case for the BowlingGame when the player scores one Spare in the first round.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testOneStrike()
    {
        self.rollStrike(); // strike - 10 points - the next two rolls count as double
        self.game.roll(3); // should add 6 instead of 3
        self.game.roll(4); // should add 8 instead of 4
        self.rollMany(16, pins: 0);
        
        XCTAssertEqual(24, self.game.score());
    }
    
    /**
     Test case for the BowlingGame when all rolls knock down 10 pins.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func testPerfectGame()
    {
        self.rollMany(12, pins: 10); // rolling 12 times all Strikes
        XCTAssertEqual(self.game.score(), 300);
    }
    
    // MARK: - Private functions
    /**
     Rolls multiple times the same amount of pins in the game.
     
     - parameter howMany: How many times the same number of pins should be rolled.
     - parameter pins:    The number of pins to be knocked down in each round.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    private func rollMany(howMany: Int, pins: Int)
    {
        for _ in 1...howMany
        {
            self.game.roll(pins);
        }
    }
    
    /**
     Rolls a Spare for the current game.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    private func rollSpare()
    {
        self.game.roll(5);
        self.game.roll(5);
    }
    
    /**
     Rolls a Strike for the current game.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    private func rollStrike()
    {
        self.game.roll(10);
    }
}
