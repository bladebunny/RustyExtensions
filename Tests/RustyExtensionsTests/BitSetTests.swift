//
//  BitSetTests.swift
//  RustyExtensions
//
//  Created by Tim Brooks on 4/2/25.
//

import XCTest
@testable import RustyExtensions

final class BitSetTests: XCTestCase {
    
    func testBasics() {
        var bitset = BitSet()

        XCTAssertFalse(bitset.contains(0), "Should not contain 0")
        XCTAssertFalse(bitset.contains(1), "Should not contain 1")

        for i in 0..<100 {
            bitset.insert(i)
        }
        
        XCTAssertTrue(bitset.contains(0), "Should contain 0")
        XCTAssertFalse(bitset.contains(99), "Should not contain 99. Max is 63.")
        XCTAssertFalse(bitset.count == 100, "Count should not be 100")
        XCTAssertTrue(bitset.count == 64, "Count should be 64")
        XCTAssertFalse(bitset.contains(64), "Should not contain 64. Max is 63.")
        XCTAssertTrue(bitset.contains(63), "Should contain 63. Max is 63.")

        bitset.insert(-1)
        XCTAssertFalse(bitset.contains(-1), "Should contain not -1. Min is 0")

        for i in 0..<100 {
            bitset.remove(i)
        }

        XCTAssertTrue(bitset.count == 0, "Should count should be 0")
    }
}
