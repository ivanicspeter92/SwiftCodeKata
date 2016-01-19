//
//  KarateChopDelegate.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 14/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

protocol KarateChopDelegate
{
    func chop(target: Int, array: [Int]) -> Int;
}