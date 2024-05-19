//
//  JSONError.swift
//
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation

public enum JSONError: Error {
    
    case dataCorrupted(String)
    case general(String)
    case keyNotFound(String)
    case typeMismatch(String)
    case valueNotFound(String)
}
