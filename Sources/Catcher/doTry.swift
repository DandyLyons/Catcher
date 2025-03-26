//
//  doTry.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation

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

