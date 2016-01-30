//
//  PetersBowlingGame.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 30/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

class PetersBowlingGame: BowlingGameDelegate
{
    class Frame
    {
        enum BowlingFrameException: ErrorType
        {
            case TooManyRolls;
        }
        /// The score of the first roll.
        private var firstRoll: Int?;
        /// The core of the second roll.
        private var secondRoll: Int?;
        
        /**
         Rolls the bowling ball and knocks down a number of pins in this frame.
         
         - parameter pins: The number of pins to be knocked down.
         
         - Author: Peter Ivanics
         - Date: 30.01.2016.
         */
        func roll(pins: Int) throws 
        {
            if self.isFinished() == false
            {
                if self.firstRoll == nil
                { self.firstRoll = pins; }
                else if self.secondRoll == nil
                { self.secondRoll = pins; }
                else
                { throw BowlingFrameException.TooManyRolls; }
            }
            else
            { throw BowlingFrameException.TooManyRolls; }
        }
        
        /**
         Gets the current score of the player.
         
         - returns: The current score of this frame. Returns nil if there wasn't any rolls yet.
         
         - Author: Peter Ivanics
         - Date: 30.01.2016.
         */
        func score() -> Int?
        {
             if let firstRoll = self.firstRoll
             {
                if let secondRoll = self.secondRoll
                { return firstRoll + secondRoll; }
                return firstRoll;
            }
            return nil;
        }
        
        /**
         Tells if the frame was a Strike.
         
         - returns: True, if the player scored a Strike in the frame; false otherwise.
         
         - Author: Peter Ivanics
         - Date: 30.01.2016.
         */
        func isStrike() -> Bool
        {
            return self.firstRoll == 10
        }
        
        
        /**
         Tells if the frame was a Spare.
         
         - returns: True, if the player scored a Spare in the frame; false otherwise.
         
         - Author: Peter Ivanics
         - Date: 30.01.2016.
         */
        func isSpare() -> Bool
        {
            if let firstRoll = self.firstRoll, secondRoll = self.secondRoll
            { return firstRoll + secondRoll == 10; }
            return false;
        }
        
        /**
         Tells is the frame is finished.
         
         - returns: True, if the frame is finished; false otherwise.
         
         - Author: Peter Ivanics
         - Date: 30.01.2016.
         */
        func isFinished() -> Bool
        {
            if self.firstRoll != nil && self.secondRoll != nil || self.firstRoll == 10
            { return true; }
            else
            { return false; }
        }
    }
    
    class LastFrame: Frame
    {
        private var extraRoll: Int?;
        
        override func isFinished() -> Bool
        {
            if (self.isSpare() || self.isStrike()) && self.extraRoll == nil
            { return false; }
            
            return super.isFinished();
        }
        
        override func roll(pins: Int) throws
        {
            do
            { try super.roll(pins); }
            catch
            {
                if self.isFinished() == false
                { self.extraRoll = pins; }
                else
                { throw BowlingFrameException.TooManyRolls; }
            }
        }
        
        override func score() -> Int?
        {
            if let result = super.score()
            {
                if let extraRoll = self.extraRoll
                    { return result + extraRoll; }
                return result;
            }
            
            return nil;
        }
        
        override func isSpare() -> Bool
        {
            if let firstRoll = self.firstRoll, secondRoll = self.secondRoll
            { return firstRoll + secondRoll == 10 && firstRoll != 0 && secondRoll != 0; }
            return false;
        }
    }
    
    /**
     Rolls the bowling ball and knocks down a number of pins for the player.
     
     - parameter pins: The number of pins to be knocked down.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func roll(pins: Int)
    {
        
    }
    
    
    /**
     Gets the current score of the player.
     
     - returns: The current score of the player in the game.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func score() -> Int
    {
        return 0;
    }
}