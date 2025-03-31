//
//  Array+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

extension Array {

    // First the first possible match that contains 'text'
    static func findFirstMatch(in text: String,
                               from possibleMatches: [String],
                               caseSensitive: Bool = true) -> String? {
        if caseSensitive {
            return possibleMatches.first { text.contains($0) }
        } else {
            let lowercaseText = text.lowercased()
            return possibleMatches.first { lowercaseText.contains($0.lowercased()) }
        }
    }
}

