//
//  ThreadHandler.swift
//  Instrument
//
//  Created by Dipendra Dubey on 03/10/23.
//

import Foundation

actor ThreadHandler{
    private(set) var array = [String]() //so now this can be set privately only
    func getUpdateValue() async -> Void{
            for index in 0...10000{
                self.array.append("\(index)")
            }
    }
    func getCount() async -> Int{
        return self.array.count
    }
}
