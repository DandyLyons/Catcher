//
//  value with defaults.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation

@available(*, deprecated, message: "The value with `default` methods are deprecated because they never actually read the error. Use the other value methods intead.")
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
@available(*, deprecated, message: "The value with `default` methods are deprecated because they never actually read the error. Use the other value methods intead.")
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
