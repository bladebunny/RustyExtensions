//
//  Bool+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 6/5/24.
//

import Foundation

extension Bool {

    public var data: Data {
        var buffer = self
        return Data(bytes: &buffer, count: MemoryLayout<Int>.size)
    }

    public init?(data: Data) {
        
        let nsData = data as NSData
        var value = false
        nsData.getBytes(&value, length: MemoryLayout<Bool>.size)
        self = value
    }
}
