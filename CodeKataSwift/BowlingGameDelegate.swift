//
//  BowlingGameDelegate.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 30/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

protocol BowlingGameDelegate
{
    /**
     Rolls the bowling ball and knocks down a number of pins for the player.
     
     - parameter pins: The number of pins to be knocked down.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func roll(pins: Int);
    
    /**
     Gets the current score of the player.
     
     - returns: The current score of the player in the game.
     
     - Author: Peter Ivanics
     - Date: 30.01.2016.
     */
    func score() -> Int;
}