//
//  Publisher+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation
import Combine

/// Convenience extension for Publisher that reduces boilerplate code on observing published values
extension Publisher where Self.Output: Equatable, Self.Failure == Never {
    public func sink(storeIn cancellables: inout Set<AnyCancellable>, completion: @escaping (Self.Output) -> Void) {
        self
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { value in
                completion(value)
            }
            .store(in: &cancellables)
    }
}

/*
 Example Usage:
 private var cancellables: Set<AnyCancellable> = []
 @Published var property: Bool = true
 
 func someFunc() {
    $property.sink(storeIn: &cancellables) { boolValue in }
 }

 // Don't forget to cleanup cancellables!!
 */
