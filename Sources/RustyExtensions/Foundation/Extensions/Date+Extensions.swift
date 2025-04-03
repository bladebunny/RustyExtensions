//
//  Date+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation

extension Date {
    
    public var secondsSince1970: Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    public var milliSecondsSince1970: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000.0)
    }
    
    public static func nowOffsetBy(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.second = seconds
        dateComponents.minute = minutes
        dateComponents.hour = hours
        dateComponents.day = days
        
        return Calendar.current.date(byAdding: dateComponents, to: .now)
    }
}
