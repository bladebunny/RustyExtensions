//
//  BundleExtensions.swift
//
//
//  Created by Tim Brooks on 5/25/24.
//

import Foundation
import SwiftUI

extension Bundle {
    
    public func decode<T: Decodable>(_ type: T.Type,
                                     from url: URL,
                                     dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
        let file = url.absoluteString
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateStrategy
        decoder.keyDecodingStrategy = keyStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
    
    
    public func decode<T: Decodable>(_ type: T.Type,
                                     resource: String,
                                     withExtension: String,
                                     dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
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
                                         keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
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
