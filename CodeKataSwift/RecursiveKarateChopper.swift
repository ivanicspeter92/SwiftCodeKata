//
//  RecursiveKarateChopper.swift
//  CodeKataSwift
//
//  Created by Peter Ivanics on 18/01/16.
//  Copyright © 2016 reslink. All rights reserved.
//

import Foundation

class RecursiveKarateChopper: KarateChopDelegate
{
    func chop(target: Int, array: [Int]) -> Int
    {
        return self.recuriveChop(target, array: array, beginIndex: 0, endIndex: array.count - 1);
    }
    
    private func recuriveChop(target: Int, array: [Int], beginIndex: Int, endIndex: Int) -> Int
    {
        if beginIndex <= endIndex
        {
            let midIndex = (beginIndex + endIndex) / 2;
        
            if array[midIndex] == target
            { return midIndex; }
            if array[midIndex] < target
            { return self.recuriveChop(target, array: array, beginIndex: midIndex + 1, endIndex: endIndex); }
            if array[midIndex] > target
            { return self.recuriveChop(target, array: array, beginIndex: beginIndex, endIndex: midIndex - 1); }
        }
        
        return -1;
    }
}