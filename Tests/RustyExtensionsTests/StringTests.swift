//
//  StringTests.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 5/18/24.
//

import XCTest
@testable import RustyExtensions

final class StringTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testBase64Encoding() throws {
        
        let original = "Let's encode this string"
        let stringEncoded = "TGV0J3MgZW5jb2RlIHRoaXMgc3RyaW5n"

        // Encoding
        let encoded = try XCTUnwrap(original.toBase64)
        XCTAssert(encoded == stringEncoded, "Base64 encoding failed")
        
        // Decoding
        let decoded = try XCTUnwrap(encoded.fromBase64)
        XCTAssert(original == decoded, "Base64 decoding failed")
    }
    
    func testReplacements() {
        
        let testString = "Hello World"
        let firstMatch = "Hell| World"

        var copy = testString
        
        copy.set(character: "|", at: 4)
        XCTAssertFalse(copy == testString)
        XCTAssertTrue(copy == firstMatch)

        // neg checks
        copy.set(character: "_", at: copy.count) // out of bounds
        XCTAssertTrue(copy == firstMatch)
        copy.set(character: "_", at: -1) // out of bounds
        XCTAssertTrue(copy == firstMatch)
    }
}
