//
//  File.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-27.
//

import Foundation

extension Optional {
    public init<E: Error>(
        for op: @autoclosure () throws(E) -> Wrapped,
        catcher: (E) -> Void
    ) {
        do {
            self = try op()
        } catch {
            catcher(error)
            self = nil
        }
    }
    
    public init(
        for op: @autoclosure () throws -> Wrapped,
        catcher: (any Error) -> Void
    ) {
        do {
            self = try op()
        } catch {
            catcher(error)
            self = nil
        }
    }
    
    public init(
        asyncFor op: @autoclosure @Sendable @escaping () async throws -> Wrapped,
        catcher: @Sendable (any Error) async -> Void
    ) async {
        do {
            self = try await op()
        } catch {
            await catcher(error)
            self = nil
        }
    }
}
