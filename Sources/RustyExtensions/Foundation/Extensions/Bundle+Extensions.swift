//
//  Bundle+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/25/24.
//

import Foundation
import SwiftUI

extension Bundle {
    
    // MARK: - Decoding
    public func decode<T: Decodable>(_ type: T.Type,
                                     from url: URL,
                                     dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, JSONDecodingError> {
        
        let file = url.absoluteString
        
        guard let data = try? Data(contentsOf: url) else {
            return Result.failure(JSONDecodingError.dataCorrupted("Failed to load \(file) from bundle."))
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateStrategy
        decoder.keyDecodingStrategy = keyStrategy
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return Result.success(result)
        } catch {
            return Result.failure(JSONDecodingError.parseDecodeError(error))
        }
    }
        
    public func decode<T: Decodable>(_ type: T.Type,
                                     resource: String,
                                     withExtension: String,
                                     dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys)  -> Result<T, JSONDecodingError> {
        
        guard let url = self.url(forResource: resource, withExtension: withExtension) else {
            fatalError("Failed to locate \(resource).\(withExtension) in bundle.")
        }
        
        return decode(type,
                      from: url,
                      dateStrategy: dateStrategy,
                      keyStrategy: keyStrategy)
    }
    
    public func decodeJson<T: Decodable>(_ type: T.Type,
                                         resource: String,
                                         dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                         keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, JSONDecodingError> {
        
        return decode(type,
                      resource: resource,
                      withExtension: "json",
                      dateStrategy: dateStrategy,
                      keyStrategy: keyStrategy)
    }
    
    public func read(resource: String, withExtension: String) -> String? {
        
        guard let url = self.url(forResource: resource, withExtension: withExtension) else {
            fatalError("Failed to locate \(resource).\(withExtension) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(url.absoluteString) from bundle.")
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    public func readJson(resource: String) -> String? {
        return read(resource: resource, withExtension: "json")
    }
}
