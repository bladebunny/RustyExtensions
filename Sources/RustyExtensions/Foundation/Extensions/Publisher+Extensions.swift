//
//  File.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 3/31/25.
//

import Foundation
import Combine

/// Convenience extension for Publisher that reduces boilerplate code on observing published values
extension Publisher where Self.Output : Equatable, Self.Failure == Never {
    func sink<T: Equatable>(storeIn cancellables: inout Set<AnyCancellable>, completion: @escaping (T) -> Void)   {
        self
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { value in
                completion(value as! T)
            }
            .store(in: &cancellables)
    }
}
