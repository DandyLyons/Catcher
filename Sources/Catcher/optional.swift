//
//  File.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-27.
//

import Foundation

extension Optional {
    /// Convert a single throwing function into an `Optional`.
    /// 
    /// This initializer will always return an `Optional`. If the throwing function succeeds, then it will have the same
    /// value as the return from the throwing function. If the throwing function fails, then the error handler will run first
    /// and then the `Optional` will be `nil`.
    /// 
    /// In my tests, it seems that Swift is not able to infer the `Error` type for the error handler, so you must declare it explicitly like this:
    /// 
    /// ```swift
    /// let opt = Optional(for: try getInt()) { (e: IntError) in
    ///    // handle error here
    /// }
    /// ```
    /// 
    /// If you do not explicitly declare the type of `e` then Swift will treat it as an `any Error`.
    /// - Parameters:
    ///   - op: the throwing function that you would like to convert to an `Optional`.
    ///   - catcher: the error handler in the case where the function throws an error.
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
    
    /// Convert a single throwing function into an `Optional`.
    ///
    /// This initializer will always return an `Optional`. If the throwing function succeeds, then it will have the same
    /// value as the return from the throwing function. If the throwing function fails, then the error handler will run first
    /// and then the `Optional` will be `nil`.
    ///
    /// In my tests, it seems that Swift is not able to infer the `Error` type for the error handler, so you must declare it explicitly like this:
    ///
    /// ```swift
    /// let opt = Optional(for: try getInt()) { (e: IntError) in
    ///    // handle error here
    /// }
    /// ```
    ///
    /// If you do not explicitly declare the type of `e` then Swift will treat it as an `any Error`.
    /// - Parameters:
    ///   - op: the throwing function that you would like to convert to an `Optional`.
    ///   - catcher: the error handler in the case where the function throws an error.
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
    
    /// Convert a single async throwing function into an `Optional`.
    ///
    /// This initializer will always return an `Optional`. If the throwing function succeeds, then it will have the same
    /// value as the return from the throwing function. If the throwing function fails, then the error handler will run first
    /// and then the `Optional` will be `nil`.
    ///
    /// In my tests, it seems that Swift is not able to infer the `Error` type for the error handler, so you must declare it explicitly like this:
    ///
    /// ```swift
    /// let opt = Optional(for: try getInt()) { (e: IntError) in
    ///    // handle error here
    /// }
    /// ```
    ///
    /// If you do not explicitly declare the type of `e` then Swift will treat it as an `any Error`.
    /// - Parameters:
    ///   - op: the throwing function that you would like to convert to an `Optional`.
    ///   - catcher: the error handler in the case where the function throws an error.
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
