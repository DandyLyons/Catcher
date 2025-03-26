//
//  value with defaults.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation


public func value<Value>(
    `default` defaultValue: Value,
    for op: @autoclosure () throws -> Value
) -> Value {
    do {
        return try op()
    } catch {
        return defaultValue
    }
}

// MARK: async
public func asyncValue<Value>(
    `default` defaultValue: Value,
    for op: @autoclosure () async throws -> Value
) async -> Value {
    do {
        return try await op()
    } catch {
        return defaultValue
    }
}
