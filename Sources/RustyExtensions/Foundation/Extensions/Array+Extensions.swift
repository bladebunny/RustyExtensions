//
//  Array+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

extension Array {

    // First the first possible match that contains 'text'
    public static func findFirstMatch(in text: String,
                               from possibleMatches: [String],
                               caseSensitive: Bool = true) -> String? {
        if caseSensitive {
            return possibleMatches.first { text.contains($0) }
        } else {
            let lowercaseText = text.lowercased()
            return possibleMatches.first { lowercaseText.contains($0.lowercased()) }
        }
    }
    
    // Remove the element at index
    public func removing(index: Int) -> [Element] {
        if index >= startIndex && index < endIndex {
            return Array(self[..<index] + self[(index + 1)..<endIndex])
        } else {
            return self
        }
    }
}

