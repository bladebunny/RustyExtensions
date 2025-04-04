//
//  Data+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation

extension Data {
    
    public var bool: Bool? {
        Bool(data: self)
    }

    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    public var int: Int {
        
        self.withUnsafeBytes { pointer in
            return pointer.load(as: Int.self)
        }
    }

    public var ut8String: String? {
        let result = String(data: self, encoding: .utf8)
        return result
    }
    
    public var string: String? {
        self.ut8String
    }
    
    public var ut16String: String? {
        return String(data: self, encoding: .utf16)
    }
    
    // JSON Decode Helper
    public func decode<A: Decodable>(dateStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) throws -> A? {
        
        // Add date strategy
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateStrategy
        
        // Catch JSON errors
        var parseError: JSONDecodingError?
        var element: A?
        
        do {
            element = try decoder.decode(A.self, from: self)
        } catch {
            parseError = JSONDecodingError.parseDecodeError(error)
        }
        
        guard let parsedElement = element else {
            throw (parseError ?? URLError(.cannotParseResponse))
        }
        
        return parsedElement
    }
    
    public var prettyPrinted: NSString? {
        
        let writingOptions: JSONSerialization.WritingOptions = [
            .prettyPrinted
        ]
        
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: writingOptions),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            
            return nil
        }
        
        return prettyPrintedString
    }
}
