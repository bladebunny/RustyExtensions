//
//  String+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation


extension String {
    
    public static let empty = ""

    public var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    /// For debug printing in order to get the Class from a file url
    var lastPathComponent: String {
        let components = self.split(separator: "/")
        guard components.count >= 1 else { return String.empty }
        return String(components[components.count - 1])
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
    
    @discardableResult
    mutating public func set(character: Character, at index: Int) -> Bool {
        
        guard (index >= 0) && (index < self.count) else { return false }
        
        self.remove(at: self.index(self.startIndex, offsetBy: index))
        self.insert(character, at: self.index(self.startIndex, offsetBy: index))
        
        return true
    }
}

extension Optional<String> {
    
    public var safe: String {
        return self ?? String.empty
    }
}
