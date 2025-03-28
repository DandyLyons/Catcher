//
//  MyStruct.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Foundation

struct MyStruct: Sendable {
    var int: Int
    enum Error: Swift.Error, Equatable, Sendable {
        case one, two, three, four
    }
    mutating func succeeding() throws -> Int {
        return int
    }
    
    mutating func throwing() throws -> Int {
        throw Error.two
    }
    mutating func typedSucceeding() throws(Self.Error) -> Int{
        return int
    }
    mutating func typedThrowing() throws(Self.Error) -> Int {
        throw Error.three
    }
    // MARK: Async
    mutating func asyncSucceeding() async throws -> Int {
        return int
    }
    
    mutating func asyncThrowing() async throws -> Int {
        throw Error.two
    }
    mutating func asyncTypedSucceeding() async throws(Self.Error) -> Int{
        return int
    }
    mutating func asyncTypedThrowing() async throws(Self.Error) -> Int {
        throw Error.three
    }
    
}
