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
struct ValueDefaultTests {
    @Test func valueDefault() throws {
        var myStruct = MyStruct(int: 1)
        let valueSucceeding = value(default: 4, for: try myStruct.succeeding())
        #expect(valueSucceeding == 1)
        
        let valueThrowing = value(default: 4, for: try myStruct.throwing())
        #expect(valueThrowing == 4)
    }
    
    @Test func asyncValueDefault() async throws {
        var myStruct = MyStruct(int: 1)
        let asyncValueSucceeding = await asyncValue(
            default: 4,
            for: try await myStruct.asyncSucceeding()
        )
        #expect(asyncValueSucceeding == 1)
        
        let asyncValueThrowing = await asyncValue(
            default: 4,
            for: try await myStruct.asyncThrowing()
        )
        #expect(asyncValueThrowing == 4)
    }
}
