//
//  Clock.swift
//  First Game
//
//  Created by Rácz Balázs on 2020. 03. 16..
//  Copyright © 2020. Rácz Balázs. All rights reserved.
//

import Foundation

class Clock {
    var startTime : Date?
    
    func starter() -> () {
        startTime = Date()
    }
    func ender() -> (){
        if let start = startTime{
            print(String(start.timeIntervalSinceNow))
        }
    }
}

