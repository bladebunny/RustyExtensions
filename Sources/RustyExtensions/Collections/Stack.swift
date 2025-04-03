//
//  Stack.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/23/25.
//

import Foundation

/// Thread-safe Stack
///
/// Stack add elements at the front such that the first element
/// is the last element stacked.
///
/// LIFO: Last-In-First-Out
///
public struct Stack<T> {
    
    private let lock = NSLock()
    private var items: [T]
    
    public init(items: [T] = []) {
        self.items = items
    }
    
    public mutating func clear() {
        
        lock.withLock {
            self.items.removeAll()
        }
    }
    
    public func peek() -> T? {
        
        var item: T?
        
        lock.withLock {
            item = self.items.last
        }
        
        return item
    }

    public mutating func push(_ element: T) {
        
        lock.withLock {
            self.items.append(element)
        }
    }
    
    public mutating func pop() -> T? {

        var item: T?

        lock.withLock {
            item = self.items.popLast()
        }

        return item
    }
}
