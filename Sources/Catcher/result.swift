//
//  result.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

extension Result {
    /// Convert a single throwing function into a `Result`.
    ///
    /// This initializer simply delegates to `Result.init(catching:)`. There's only one small advantage
    /// to using this initializer: this initializer allows you to use one and only one `try` statement, meaning that
    /// if and when your function throws an error, you know exactly which function threw the error (because there
    /// is only one). Whereas when using `init(catching:)` when the result value is a `Result.failure`
    /// you have no way of knowing which throwing function actually threw the error. 
    public init(for op: @autoclosure () throws(Failure) -> Success) {
        self.init(catching: op)
    }
}

public func result<Value>(
    for op: @autoclosure () throws -> Value
) -> Result<Value, any Error> {
    do {
        return Result.success(try op())
    } catch {
        return Result.failure(error)
    }
}

public func result<Value, E: Error>(
    for op: @autoclosure () throws(E) -> Value
) -> Result<Value, E> {
    do {
        return Result.success(try op())
    } catch {
        return Result.failure(error)
    }
}

// MARK: async
public func asyncResult<Value>(
    for op: @autoclosure () async throws -> Value
) async -> Result<Value, any Error> {
    do {
        return Result.success(try await op())
    } catch {
        return Result.failure(error)
    }
}

public func asyncResult<Value, E: Error>(
    for op: @autoclosure () async throws(E) -> Value
) async -> Result<Value, E> {
    do {
        return Result.success(try await op())
    } catch {
        return Result.failure(error)
    }
}


