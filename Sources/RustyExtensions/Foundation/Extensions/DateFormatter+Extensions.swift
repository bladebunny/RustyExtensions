//
//  DateFormatter+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation

extension DateFormatter {
    
    public static let defaultFormatter: DateFormatter = {
        return formatter()
    }()

    public static var now: String {
        return DateFormatter.defaultFormatter.string(from: Date())
    }

    public static func stringFor(date: Date) -> String {
        return DateFormatter.defaultFormatter.string(from: date)
    }
    
    public static func formatter(for pattern: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                          locale: Locale = Locale(identifier: "en_US_POSIX"),
                          timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> DateFormatter {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
     
        return dateFormatter
    }
}
