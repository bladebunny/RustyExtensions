//
//  DictionaryExtensions.swift
//
//
//  Created by Tim Brooks on 5/25/24.
//

import Foundation

extension Dictionary {
    
    public var toJson: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
