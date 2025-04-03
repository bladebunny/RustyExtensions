//
//  Int+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 6/5/24.
//

import Foundation

extension Int {
    
    public var data: Data {
        
        var buffer = self
        return Data(bytes: &buffer, count: MemoryLayout<Int>.size)
    }
}
