//
//  XCTest+Extensions.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/23/24.
//

import Foundation
import XCTest

extension XCTest {

    // MARK: - Async Versions of Throwing test functions not yet provided by Apple
    public func XCTAsyncAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T,
                                        _ message: @autoclosure () -> String = "",
                                        _ errorHandler: (_ error: Error) -> Void = { _ in }) async {

        do {
            _ = try await expression()
            XCTFail(message())
        } catch {
            errorHandler(error)
        }
    }
    
    public func XCTAsyncAssertNoThrow<T>(_ expression: @autoclosure () async throws -> T,
                                    _ message: @autoclosure () -> String = "") async {
        
        do {
            _ = try await expression()
        } catch {
            XCTFail(message())
        }
    }
}
