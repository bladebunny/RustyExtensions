//
//  DataExtensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation

extension Data {
    
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    public var ut8String: String? {
        let result = String(data: self, encoding: .utf8)
        return result
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
        var parseError: JSONError?
        var errorMessage = String.empty
        var element: A?

        do {
            element = try decoder.decode(A.self, from: self)
        } catch let DecodingError.dataCorrupted(context) {

            errorMessage = decodingInfo(prefix: "Data Corrupted: ", context: context)
            parseError = .dataCorrupted(errorMessage)

        } catch let DecodingError.keyNotFound(_, context) {

            errorMessage = decodingInfo(prefix: "Key not found: ", context: context)
            parseError = .keyNotFound(errorMessage)

        } catch let DecodingError.valueNotFound(_, context) {

            errorMessage = decodingInfo(prefix: "Value not found: ", context: context)
            parseError = .valueNotFound(errorMessage)

        } catch let DecodingError.typeMismatch(_, context) {
            
            errorMessage = decodingInfo(prefix: "Type Mismatch: ", context: context)
            parseError = .typeMismatch(errorMessage)

        } catch {
            errorMessage = """
            
            General error: \(error.localizedDescription)
            """
            
            parseError = .general(errorMessage)
        }
                
        guard let parsedElement = element else {
            throw (parseError ?? URLError(.cannotParseResponse))
        }
        
        return parsedElement
    }
    
    private func decodingInfo(prefix: String = String.empty, context: DecodingError.Context) -> String {
        
        var result = "\(prefix)\(context.debugDescription)"
        var path = String.empty
        
        for codingKey in context.codingPath {
            if path.isEmpty {
                path.append(codingKey.stringValue)
            } else {
                path.append(".\(codingKey.stringValue)")
            }
        }
        
        // Start w/line break
        result = """
        
        \(result)
        """
        
        if !path.isEmpty {

            // Append path: eg Parent.child.property
            result = """
            \(result)
            Path: \(path)
            """
        }
        
        if let underlyingError = context.underlyingError {

            // Append source error
            result = """
            \(result)
            Source Error: \(underlyingError.localizedDescription)
            """
        }
        
        return result
    }
}
