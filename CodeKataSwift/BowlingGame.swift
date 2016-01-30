//
//  BowlingGame.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 30/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

class BowlingGame: BowlingGameDelegate
{
    /// The array what contains number of pins knocked down in each turn.
    private var rolls = [Int]();
    private var currentRoll = 0;
    
    /**
     Rolls the bowling ball and knocks down a number of pins for the player.
     
     - parameter pins: The number of pins to be knocked down.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func roll(pins: Int)
    {
        self.rolls.append(pins);
    }
    
    /**
     Gets the current score of the player. Should be called only at the end of the game.
     
     - returns: The current score of the player in the game.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func score() -> Int
    {
        var cumulatedScore = 0;
        var frameIndex = 0;
        
        for frame: Int in 0...9
        {
            if frameIndex + 1 >= self.rolls.count // avoiding out of range exception
            { break; }
            
            if self.isStrike(frameIndex)
            {
                cumulatedScore += 10 + self.strikeBonus(frameIndex); // adding the value of the next two rolls once more
                frameIndex++;
            }
            else if self.isSpare(frameIndex) // spare
            {
                cumulatedScore += 10 + self.spareBonus(frameIndex); // adding the value of the next roll once more
                frameIndex += 2;
            }
            else
            {
                cumulatedScore += self.sumBallsInFrame(frameIndex);
                frameIndex += 2;
            }
        }
        return cumulatedScore;
    }
    
    // MARK: - Private methods
    /**
    Tells if the frame was a Spare.
    
    - parameter frameNumber: The number of the frame to be checked.
    
    - returns: True, if the player scored a Spare in the frame; false otherwise.
    
    - Author: Peter Ivanics
    - Date: 30.01.2016.
    */
    private func isSpare(frameIndex: Int) -> Bool
    {
        if self.rolls[frameIndex] + self.rolls[frameIndex + 1] == 10
        { return true; }
        return false;
    }
    
    /**
     Tells if the frame was a Strike.
     
     - parameter frameNumber: The number of the frame to be checked.
     
     - returns: True, if the player scored a Strike in the frame; false otherwise.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    private func isStrike(frameIndex: Int) -> Bool
    {
        if self.rolls[frameIndex] == 10
        { return true; }
        return false;
    }
    
    private func strikeBonus(frameIndex: Int) -> Int
    {
        if frameIndex + 2 < self.rolls.count
        {
        return self.rolls[frameIndex + 1] + self.rolls[frameIndex + 2];
        }
        else
        { return 0; }
    }
    
    private func spareBonus(frameIndex: Int) -> Int
    {
        return self.rolls[frameIndex + 2];
    }
    
    private func sumBallsInFrame(frameIndex: Int) -> Int
    {
        return self.rolls[frameIndex] + self.rolls[frameIndex + 1];
    }
}