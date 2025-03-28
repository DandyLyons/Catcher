//
//  optional tests.swift
//  Catcher
//
//  Created by Daniel Lyons on 2025-03-27.
//

import Catcher
import Foundation
import Testing

@Suite
struct OptionalTests {
    @Test func optionalInit() {
        var myStruct = MyStruct(int: 1)
        
        let succeeding = Optional(
            for: try myStruct.succeeding(),
            catcher: { error in
                Issue.record("This should not throw")
            }
        )
        #expect(succeeding == 1)
        
        let throwing = Optional(
            for: try myStruct.throwing(),
            catcher: { error in
                print(error)
            }
        )
        #expect(throwing == nil)
    }
    
    @Test func typedOptionalInit() {
        var myStruct = MyStruct(int: 1)
        let typedSucceeding = Optional(
            for: try myStruct.typedSucceeding(),
            catcher: { (error: MyStruct.Error) in
                Issue.record("This should not throw")
            }
        )
        #expect(typedSucceeding == 1)
        
        let typedThrowing = Optional(
            for: try myStruct.typedThrowing(),
            catcher: { (error: MyStruct.Error) in
                #expect(error == .three)
            }
        )
        #expect(typedThrowing == nil)
    }
    
//    @Test func asyncOptionalInit() async {
//        var myStruct = MyStruct(int: 1)
//        
//        let asyncSucceeding = await Optional(
//            asyncFor: try await myStruct.asyncSucceeding(),
//            catcher: { error in
//                print(error)
//            }
//        )
//        #expect(asyncSucceeding == 1)
//        
//        let asyncThrowing = await Optional(
//            asyncFor: try await myStruct.asyncThrowing(),
//            catcher: { error in
//                print(error)
//            }
//        )
//        #expect(asyncThrowing == nil)
//    }
}
