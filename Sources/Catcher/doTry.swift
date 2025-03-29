//
//  doTry.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation
/// Use it like a `do` `catch` block.
///
/// This function is negligibly better than a vanilla Swift `do` `catch` block. The ergonomics are slightly worse, but there is one
/// small advantage to using it which is that this function forces you to use one and only one throwing function, which then means
/// that if and when you catch an error, you know exactly which function threw the error.
public func doTry(
    _ op: @autoclosure () throws -> Void,
    catching errorHandler: (any Error) -> Void
) {
    do {
        try op()
    } catch {
        errorHandler(error)
    }
}

/// Use it like a `do` `catch` block.
///
/// This function is negligibly better than a vanilla Swift `do` `catch` block. The ergonomics are slightly worse, but there is one
/// small advantage to using it which is that this function forces you to use one and only one throwing function, which then means
/// that if and when you catch an error, you know exactly which function threw the error.
public func doTry<E: Error>(
    _ op: @autoclosure () throws(E) -> Void,
    catching errorHandler: (E) -> Void
) {
    do {
        try op()
    } catch {
        errorHandler(error)
    }
}

// MARK: async

/// Use it like a `do` `catch` block for async work.
///
/// This function is negligibly better than a vanilla Swift `do` `catch` block. The ergonomics are slightly worse, but there is one
/// small advantage to using it which is that this function forces you to use one and only one throwing function, which then means
/// that if and when you catch an error, you know exactly which function threw the error.
public func asyncDoTry(
    _ op: @autoclosure () async throws -> Void,
    catching errorHandler: (any Error) async -> Void
) async {
    do {
        try await op()
    } catch {
        await errorHandler(error)
    }
}

/// Use it like a `do` `catch` block for async work. 
///
/// This function is negligibly better than a vanilla Swift `do` `catch` block. The ergonomics are slightly worse, but there is one
/// small advantage to using it which is that this function forces you to use one and only one throwing function, which then means
/// that if and when you catch an error, you know exactly which function threw the error.
public func asyncDoTry<E: Error>(
    _ op: @autoclosure () async throws(E) -> Void,
    catching errorHandler: (E) async -> Void
) async {
    do {
        try await op()
    } catch {
        await errorHandler(error)
    }
}

