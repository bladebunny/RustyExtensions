//
//  String+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation

extension String {
    
    // MARK: - String checks
    public static var comma: String { "," }
    public static var empty: String { "" }
    public static var space: String { " " }

    public static var emptyChar: Character { return Self.empty[Self.empty.startIndex] }
    
    // MARK: - String checks
    public var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - String components
    /// For debug printing in order to get the Class from a file url
    public var lastPathComponent: String {
        let components = self.split(separator: "/")
        guard components.count >= 1 else { return String.empty }
        return String(components[components.count - 1])
    }

    // MARK: - Manipulation
    public func character(at index: Int) -> String? {
        if index < 0 || index >= self.count {
            return nil
        }

        let charIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[charIndex])
    }
    
    public mutating func insert(_ string: String, at index: Int) {
        if index < 0 || index >= self.count {
            return
        }
        
        let insertIndex = self.index(self.startIndex, offsetBy: index)
        self.insert(contentsOf: string, at: insertIndex)
    }

    @discardableResult
    public mutating func remove(at index: Int) -> String? {
        if index < 0 || index >= self.count {
            return nil
        }
        
        let removeIndex = self.index(self.startIndex, offsetBy: index)
        return String(self.remove(at: removeIndex))
    }

    @discardableResult
    public mutating func set(character: Character, at index: Int) -> Bool {
        
        guard (index >= 0) && (index < self.count) else { return false }
        
        self.remove(at: self.index(self.startIndex, offsetBy: index))
        self.insert(character, at: self.index(self.startIndex, offsetBy: index))
        
        return true
    }

    // MARK: - Formats
    public var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    public var toBase64: String? {
        self.data(using: .utf8)?.base64EncodedString()
    }
    
    public var urlDecoded: String? {
        self.removingPercentEncoding
    }

    public var urlEncoded: String? {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
    }
    
    // MARK: - Search
    public func findFirstMatch(from possibleMatches: [String], caseSensitive: Bool = true) -> String? {
        return Array<String>.findFirstMatch(in: self, from: possibleMatches, caseSensitive: caseSensitive)
    }

    // MARK: - Printing
    public static func prettify(json: [String: Any]?) -> String {
        
        guard let json = json else { return String.empty }
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: json,
            options: [JSONSerialization.WritingOptions.prettyPrinted, JSONSerialization.WritingOptions.sortedKeys]) {
            if let theJSONText = String(data: theJSONData, encoding: .utf8) {
                return theJSONText
            } else {
                return String.empty
            }
        }
        
        return String.empty
    }
}

extension Optional<String> {
    
    public var safe: String {
        return self ?? String.empty
    }
}
