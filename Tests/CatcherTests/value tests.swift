//
//  value tests.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-25.
//

import Catcher
import Foundation
import Testing

@Suite
struct ValueTests {
    @Test func valueForSucceeding() throws {
        var myStruct = MyStruct(int: 1)
        let value = value(
            for: try myStruct.succeeding(),
            replaceErrorWithValue: { e in return 4 }
        )
        #expect(value == 1)
    }
    
    @Test func valueForThrowing() {
        var myStruct = MyStruct(int: 1)
        let value = value(
            for: try myStruct.throwing(),
            replaceErrorWithValue: { e in return 4}
        )
        #expect(value == 4)
    }
    
    @Test func valueForTypedSucceeding() {
        var myStruct = MyStruct(int: 1)
        let value = value(
            for: try myStruct.typedSucceeding(),
            replaceTypedErrorWithValue: { (e: MyStruct.Error) in return 4 }
        )
        #expect(value == 1)
    }
    
    @Test func valueForTypedThrowing() {
        var myStruct = MyStruct(int: 1)
        let value = value(
            for: try myStruct.typedThrowing(),
            replaceTypedErrorWithValue: { (e: MyStruct.Error) in return 4}
        )
        #expect(value == 4)
    }
    
    @Test func asyncValues() async {
        var myStruct = MyStruct(int: 1)
        let asyncValueSucceeding: Int = await asyncValue(
            for: try await myStruct.asyncSucceeding(),
            replaceErrorWithValue: { e in 3}
        )
        #expect(asyncValueSucceeding == 1)
        
        let asyncValueThrowing: Int = await asyncValue(
            for: try await myStruct.asyncThrowing(),
            replaceErrorWithValue: { e in 3 }
        )
        #expect(asyncValueThrowing == 3)
    }
    
    @Test func asyncValuesTypedError() async {
        var myStruct = MyStruct(int: 1)
        let asyncValueSucceeding: Int = await asyncValue(
            for: try await myStruct.asyncTypedSucceeding(),
            replaceTypedErrorWithValue: { (e: MyStruct.Error) in 3}
        )
        #expect(asyncValueSucceeding == 1)
        
        let asyncValueThrowing: Int = await asyncValue(
            for: try await myStruct.asyncTypedThrowing(),
            replaceTypedErrorWithValue: { (e: MyStruct.Error) in 3 }
        )
        #expect(asyncValueThrowing == 3)
    }
}
