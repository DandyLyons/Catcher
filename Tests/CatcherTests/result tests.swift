//
//  File.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Catcher
import Foundation
import Testing



@Suite
struct ResultTests {
    @Test func resultInitSucceeding() {
        var myStruct = MyStruct(int: 1)
        // 😞 👇🏼 Swift compiler doesn't seem to be able to infer the error type here. 
        let result = Result<Int, MyStruct.Error>(for: try myStruct.typedSucceeding())
        switch result {
            case let .success(value):
                #expect(value == myStruct.int)
            case .failure:
                Issue.record("succeeding throwing function should not yield Result.failure")
        }
    }
    
    @Test func resultInitThrowing() {
        var myStruct = MyStruct(int: 1)
        let result = Result<Int, MyStruct.Error>(for: try myStruct.typedThrowing())
        switch result {
            case .success(_):
                Issue.record("throwing function should never return Result.succeed")
            case let .failure(error):
                #expect(error == .three)
        }

    }
    
    @Test func resultForSucceeding() {
        var myStruct = MyStruct(int: 1)
        let result = result(for: try myStruct.succeeding())
        switch result {
            case let .success(value):
                #expect(value == myStruct.int)
            case .failure:
                Issue.record("succeeding throwing function should not yield Result.failure")
        }
    }
    
    @Test func resultForThrowing() {
        var myStruct = MyStruct(int: 1)
        let result = result(for: try myStruct.throwing())
        switch result {
            case .success(_):
                Issue.record("throwing function should never return Result.succeed")
            case let .failure(error):
                let maybeMyStructError: MyStruct.Error? = error as? MyStruct.Error
                switch maybeMyStructError {
                    case .none: Issue.record("failing throwing function should return the same error type")
                    case let .some(e):
                        #expect(e == .two)
                }
        }
    }
    
    @Test func resultForTypedSucceeding() {
        var myStruct = MyStruct(int: 1)
        let result: Result<Int, MyStruct.Error> = result(for: try myStruct.typedSucceeding())
        #expect(result == .success(1))
    }
    
    @Test func resultForTypedThrowing() {
        var myStruct = MyStruct(int: 1)
        let result: Result<Int, MyStruct.Error> = result(for: try myStruct.typedThrowing())
        #expect(result == .failure(.three))
        
    }
    
}
