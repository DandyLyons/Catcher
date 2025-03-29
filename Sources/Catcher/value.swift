//
//  value.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation

/// Extracts the return value of a throwing function while called in a non-throwing context.
/// - Parameters:
///   - op: TThe throwing operation to perform. Only one `try` function can and should be used.he throwing operation to perform. Only one `try` function can and should be used.
///   - onError: The error handler. You should read the error to help decide a reasonable value to replace it with.
/// - Returns: The returned value, either from the throwing function (on success) or from your error handler (on failure).
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

/// Extracts the return value of a throwing function while called in a non-throwing context.
/// - Parameters:
///   - op: The throwing operation to perform. Only one `try` function can and should be used.
///   - onError: The error handler. You should read the error to help decide a reasonable value to replace it with.
/// - Returns: The returned value, either from the throwing function (on success) or from your error handler (on failure).
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
/// Extracts the return value of a throwing function while called in a non-throwing context.
/// - Parameters:
///   - op: The throwing operation to perform. Only one `try` function can and should be used.
///   - onError: The error handler. You should read the error to help decide a reasonable value to replace it with.
/// - Returns: The returned value, either from the throwing function (on success) or from your error handler (on failure).
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

/// Extracts the return value of a throwing function while called in a non-throwing context.
/// - Parameters:
///   - op: The throwing operation to perform. Only one `try` function can and should be used.
///   - onError: The error handler. You should read the error to help decide a reasonable value to replace it with.
/// - Returns: The returned value, either from the throwing function (on success) or from your error handler (on failure).
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
