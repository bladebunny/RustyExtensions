//
//  Queue.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation

/// Thread-safe Queue
///
/// Queues add elements at the back such that the first element
/// is the element that has been enqueued the longest.
///
/// FIFO: Fast-In-First-Out
/// 
class Queue<T> {

    private let lock = NSLock()
    private var queue: [T] = []

    /// Number of elements in the Queue
    var size: Int {        
        
        var count = 0
        lock.withLock {
            count = self.queue.count
        }
        
        return count
    }

    /// Remove all elements from the Queue
    func clear() {
        lock.withLock {
            self.queue.removeAll()
        }
    }
    
    /// Gets the first element in the Queue
    /// if present
    ///
    /// - Returns: Optional, generic element of type T
    func peek() -> T? {

        var item: T?
        lock.withLock {
            item = peek(at: 0)
        }
        
        return item
    }

    /// Gets the 'at' element in the Queue
    /// if present
    ///
    /// - Parameter at: Index of the requested element
    /// - Returns: Optional, generic element of type T
    func peek(at: Int) -> T? {

        var value: T?
        lock.withLock {
            if self.queue.count > at {
                value = self.queue[at]
            }
        }
        
        return value
    }

    /// Adds an element to the back Queue
    ///
    /// - Parameter value: A value of type T
    func enqueue(_ value: T) {

        lock.withLock {
            self.queue.append(value)
        }
    }

    /// Removes the top or front element from the Queue
    ///
    /// - Returns: An optional value of type T, if present
    @discardableResult
    func dequeue() -> T? {

        var value: T?
        lock.withLock {
            if !self.queue.isEmpty {
                value = self.queue.remove(at:0)
            }
        }

        return value
    }
}
