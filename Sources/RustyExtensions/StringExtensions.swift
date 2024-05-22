//
//  StringExtensions.swift
//
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation


extension String {
    
    public static let empty = ""
        
    public var toBase64: String? {
        self.data(using: .utf8)?.base64EncodedString()
    }
    
    public var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
    
    public var urlEncoded: String? {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
    }
    
    public var urlDecoded: String? {
        self.removingPercentEncoding
    }
}

extension Optional<String> {
    
    public var safe: String {
        return self ?? String.empty
    }
}
