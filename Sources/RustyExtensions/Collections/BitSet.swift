//
//  BitSet.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/26/25.
//

import Foundation

/// Thread-safe BitSet
///
/// More efficient storage for small array
/// of integers
///
public struct BitSet {
    
    // Note: BitSet uses a UInt64 so supports
    // from 0..<64. Highest == 63, Lowest == 0, Count == 64
    private let lock = NSLock()
    private var bits: UInt64
    
    public init(with value: Int? = nil) {
        self.bits = 0
        
        if let value = value {
            self.insert(value)
        }
    }
    
    public mutating func insertValues(_ values: [Int]) {
        
        lock.withLock {
            for value in values {
                self.bits |= 1 << value
            }
        }
    }
    
    public mutating func insert(_ value: Int) {
        
        lock.withLock {
            self.bits |= 1 << value
        }
    }
    
    public func contains(_ value: Int) -> Bool {
        
        var contains = false
        lock.withLock {
            contains = (self.bits & (1 << value)) != 0
        }
        
        return contains
    }
    
    
    public var count: Int {
        var count = 0
        lock.withLock {
            count = self.bits.nonzeroBitCount
        }
        
        return count
    }
    
    public func values() -> [Int] {
        var values: [Int] = []
        lock.withLock {
            for i in 0..<64 {
                if (self.bits & (1 << i)) != 0 {
                    values.append(i)
                }
            }
        }
        
        return values
    }
    
    public mutating func remove(_ value: Int) {
        
        lock.withLock {
            self.bits &= ~(1 << value)
        }
    }
    
    public mutating func removeAll() {
        lock.withLock {
            self.bits = 0
        }
    }
}
