//
//  result.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

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


