//
//  JSONError.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation

public enum JSONDecodingError: Error, CustomDebugStringConvertible {
    
    case dataCorrupted(String)
    case general(String)
    case keyNotFound(String)
    case loadFailure(String)
    case typeMismatch(String)
    case valueNotFound(String)
    case unknown(String)
    
    // MARK: - Helper properties
    public var debugDescription: String {
        
        // Just care about the message here, not the type
        switch self {
        case .dataCorrupted(let message): fallthrough
        case .general(let message): fallthrough
        case .keyNotFound(let message): fallthrough
        case .loadFailure(let message): fallthrough
        case .typeMismatch(let message): fallthrough
        case .valueNotFound(let message): fallthrough
        case .unknown(let message):
            return message
        }
    }
    
    // MARK: - JSON Error Parsing helper
    public static func parseDecodeError(_ error: Error) -> JSONDecodingError {
        
        // Catch JSON errors
        var parseError: JSONDecodingError = .unknown("Not Parsed")
        var errorMessage = String.empty
        
        if let decodingError = error as? DecodingError {
            
            switch decodingError {
                
            case .typeMismatch(_, let context):
                errorMessage = decodingInfo(prefix: "Type Mismatch: ", context: context)
                parseError = .typeMismatch(errorMessage)
                
            case .valueNotFound(_, let context):
                errorMessage = decodingInfo(prefix: "Value not found: ", context: context)
                parseError = .valueNotFound(errorMessage)
                
            case .keyNotFound(_, let context):
                errorMessage = decodingInfo(prefix: "Key not found: ", context: context)
                parseError = .keyNotFound(errorMessage)
                
            case .dataCorrupted(let context):
                errorMessage = decodingInfo(prefix: "Data Corrupted: ", context: context)
                parseError = .dataCorrupted(errorMessage)
                
            @unknown default:
                parseError = .unknown("Unknown JSON DecodingError: \(error.localizedDescription)")
            }
        } else {
            errorMessage = "Unknown Error: \(error.localizedDescription)"
            parseError = .general(errorMessage)
        }
        
        return parseError
    }
    
    private static func decodingInfo(prefix: String = String.empty, context: DecodingError.Context) -> String {
        
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
