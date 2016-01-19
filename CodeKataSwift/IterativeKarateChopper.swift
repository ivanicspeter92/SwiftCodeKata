//
//  IterativeKarateChopper.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 14/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

class IterativeKarateChopper: KarateChopDelegate
{
    func chop(target: Int, array: [Int]) -> Int
    {
        var begin = 0, end = array.count - 1;
        
        while (begin <= end)
        {
            let mid = (end + begin) / 2;
            
            if array[mid] < target
            { begin = mid + 1; }
            if array[mid] > target
            { end = mid - 1; }
            if array[mid] == target
            { return mid; }
        }
        return -1;
    }
}