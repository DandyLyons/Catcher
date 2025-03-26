//
//  value.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation

public func value<Value>(
    for op: @autoclosure () throws -> Value,
    replaceErrorWithValue onError: (any Error) -> Value
) -> Value {
    do {
        return try op()
    } catch {
        return onError(error)
    }
}

public func value<Value, E: Error>(
    for op: @autoclosure () throws(E) -> Value,
    replaceTypedErrorWithValue onError: (E) -> Value
) -> Value {
    do {
        return try op()
    } catch {
        return onError(error)
    }
}

// MARK: async
public func asyncValue<Value>(
    for op: @autoclosure () async throws -> Value,
    replaceErrorWithValue onError: (any Error) async -> Value
) async -> Value {
    do {
        return try await op()
    } catch {
        return await onError(error)
    }
}

public func asyncValue<Value, E: Error>(
    for op: @autoclosure () async throws(E) -> Value,
    replaceTypedErrorWithValue onError: (E) async -> Value
) async -> Value {
    do {
        return try await op()
    } catch {
        return await onError(error)
    }
}
