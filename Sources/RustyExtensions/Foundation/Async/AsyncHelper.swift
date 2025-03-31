//
//  File.swift
//
//
//  Created by Tim Brooks on 6/5/24.
//

import Foundation

public typealias AsyncExpression<T> = () async -> T
public typealias AsyncThrowingExpression<T> = () async throws -> T

/*
public struct AsyncHelper {
    
    public static func concurrentAll<TaskResult, GroupResult>(
        _ expressions: AsyncExpression<TaskResult> ...,
        transform: ([TaskResult]) -> GroupResult) async -> GroupResult {
            
            await withTaskGroup(of: TaskResult.self) { group in
                
            for expression in expressions {
                group.addTask {
                    return await expression()
                }
            }
            
            var products: [TaskResult] = []
            
            // Check for cancellation before waiting
            try? Task.checkCancellation()
            for await product in group {
                products.append(product)
            }
            
            // Check for cancellation before transforming
            try? Task.checkCancellation()
            
            return transform(products)
        }
    }
    
    public static func concurrentAllThrowing<TaskResult, GroupResult>(
        _ expressions: AsyncExpression<TaskResult> ...,
        transform: ([TaskResult]) throws -> GroupResult) async throws -> GroupResult {
        
        try await withThrowingTaskGroup(of: TaskResult.self) { group in
            
            for expression in expressions {
                group.addTask {
                    return await expression()
                }
            }
            
            var products: [TaskResult] = []
            
            // Check for cancellation before waiting
            try Task.checkCancellation()
            for try await product in group {
                products.append(product)
            }
            
            // Check for cancellation before transforming
            try Task.checkCancellation()
            
            return try transform(products)
        }
    }
}
*/
