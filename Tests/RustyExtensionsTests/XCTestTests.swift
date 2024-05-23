//
//  XCTestTests.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import Foundation
import XCTest
@testable import RustyExtensions

final class XCTestTests: XCTestCase {
    
    override func setUp() async throws {}
    override func tearDown() async throws {}
    
    func testAsyncThrows() async throws {
        
        let task = Task {
            throw URLError(.unknown)
        }
        
        await XCTAsyncAssertThrowsError(try await task.value)
    }
    
    func testAsyncThrowsErrorHandling() async throws {
        
        let task = Task {
            throw URLError(.unknown)
        }
        
        await XCTAsyncAssertThrowsError(try await task.value) { error in
            XCTAssert(error is URLError)
        }
    }
    
    func testAsyncNoThrow() async throws {
        
        let task = Task<String, Error> {
            return "Not throwing."
        }
        
        await XCTAsyncAssertNoThrow(try await task.value)
    }
}
