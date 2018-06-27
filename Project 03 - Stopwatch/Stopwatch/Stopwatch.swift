//
//  Stopwatch.swift
//  Stopwatch
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
    
    private var startTime: Date?
    
    var elapsedTime: TimeInterval {
        if let startTime = startTime {
            return elapsedTimeToLastPause - startTime.timeIntervalSinceNow
        } else {
            return elapsedTimeToLastPause
        }
    }
    
    private var elapsedTimeToLastPause: TimeInterval = 0
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = Date()
    }
    
    func pause() {
        elapsedTimeToLastPause = elapsedTime
        startTime = nil
    }
    
    func stop() {
        elapsedTimeToLastPause = 0
        startTime = nil
    }
}
