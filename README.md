# Catcher
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FCatcher%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/DandyLyons/Catcher) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FCatcher%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/DandyLyons/Catcher) 

Stop fighting with Swift's frustrating do-catch blocks. Catch errors simply. 

## Motivation
Swift's error handling is powerful, safe and well-designed. But `do` `catch` blocks have meaningful flaws which leads to complex code reasoning, false sense of security, and unhandled errors.

To fully understand the problem you should read my deep dives here: 
1. [Swift Error Handling: The Problem](https://dandylyons.net/posts/post-31/swift-error-handling-the-problem/)
2. [Swift Error Handling: The Solution](https://dandylyons.net/posts/post-32/swift-error-handling-the-solution/)

I'll summarize the main points here:

1. `do` blocks with multiple `try` statements are problematic because: 
   1. When the function errors and jumps to the `catch` block, it is not clear which `try` statement caused the error.
   2. (Most of the time) the error is untyped, so you have to dynamically cast it to the correct type before you can read and handle it.
   3. The [Trapped Scope Problem]() The result of the `try` statement is not available outside of the `do` block, so in practice you end up putting more work in the `do` block (which only exacerbates the problem).
   4. Thrown errors abruptly exit the `do` block, which creates multiple code paths you have to consider.
2. Swift actually has TWO type systems: 
   1. The type system for the function signature including the return type. 
   2. The type system for the thrown error. 

### Design Goals
>[!WARNING] Not API Stable
> This library is currently in beta development and is not API stable. The API may change in the future without notice. 

This library provides various tool to handle errors in a more ergonomic way through the following strategies: 

#### Convert Throwing Functions to Non-Throwing Values
Any function marked `throws` effectively has two return types:
1. The return type of the function
2. The error type

This library provides convenient functions to convert the two return types into a single return type such as `Optional`, `Result`, or a default value.

#### Avoid the Usage of Problematic `do` `catch` Blocks
`catch` blocks do not tell you which `try` statement caused the error. This library provides a way to handle errors in place without the need for a `do` `catch` block.

#### Handle Errors From A Single Throwing Function
To convert throwing functions, the library not only accepts throwing closures, but also applies the `@autoclosure` attribute. This is mainly for one reason: the `@autoclosure` forces us to send in one and only one throwing function. This means that we know exactly what triggered our catch block.

#### Handle Errors in Place
This library operates under the philosophy each throwing function should be handled in one of two ways:
1. Call the `try` function within a `throws` context so that the error can "bubble up" and be handled by the appropriate caller.
2. Handle the error in place, immediately before proceeding so that we know exactly what caused the error.

#### Embrace Typed Errors
Swift 6 introduced typed errors, which allows us to define the error type in the function signature. This library embraces this new feature and attempts to have feature parity between typed and untyped errors.
#### Full Support for `async` `await` 
This library fully supports `async` `await` and provides the same functionality for `async` functions.

## Usage
This library provides safer strategies to run throwing functions without: 
1. creating a `throws` context
2. creating a `do` `catch` block

Catch and handle your errors simply and ergonomically by: 
1. replacing the error with an `Optional`
2. replacing the error with a reasonable value
3. bundling the error and value in a `Result`
4. simply handling the error in place

### Replacing the Error with an Optional
The library comes with a new initializer for `Optional` which allows you to provide a closure
to read and handle the error. Then it's easy to unwrap it, just like any other `Optional`. 
```swift
func throwing() throws -> Int { 1 }

func printThrowing() {
    guard let int = Optional(
        for: try myStruct.succeeding(),
        catcher: { error in
            // handle the error here
        }
    ) else {
// This is where we usually usually "handle" errors. 
// Except we don't actually know what the error is because Swift doesn't 
// give it to us here. 
    }
    print(int) // 1
}
```

#### Why not use `try?`
The obvious question is why not just use `try?`. Here, `try?` is definitely easier to read, write
and understand. But there is just one problem: 

```swift
func printThrowing() {
    guard let int = try? throwing() else {
        // What's the error? 
    }
    print(int) // 1
}
```

Where's the error? We don't have it because `try?` never gives it to us. You have never actually handled
the error because you don't even know what it is. If you are confident that you can safely ignore 
error then go ahead and use `try?`. It's a lot more convenient. But if you want to actually handle the 
error, then consider using the new `Optional` initializer. 

### Replacing the Error with a Value

```swift
func throwing() throws -> Int { 1 }

func printThrowing() {
    let int = value(default: -1, for: try throwing())
    print(int) // 1
}
```
You can parse the error to decide on a replacement value. 

```swift
func printThrowing() {
    let int = value(
        for: try throwing(),
        replaceErrorWithValue: { e in
            // decide how to handle the error here and
            // replace with a reasonable value
        }
    )
    print(int)
}
```

### Bundling the Error and Value in a `Result`
Another option is bundling it all in a `Result` so that you can handle it elsewhere. 
```swift
func printThrowing() {
    let result = result(for: try throwing())
// result is `Result<Int, MyError>`
}
```

### Handling the Error in Place
If your throwing function returns `Void` then you can handle the `Error` in place using `doTry()`. 
```swift
func printThrowing() {
    doTry(
        try throwing(),
        catching: { e in
            print(e)
        }
    )
}
```

You might be thinking, why not just use a `do` `catch` block here like this: 
```swift
func printThrowing() {
    do {
        try throwing()
    } catch {
        print(error)
    }
}
```

The truth is, a `do` `catch` is better here in most ways. It's shorter, simpler, and easier to read. Here `doTry` has only one small advantage,
which is that `doTry` should only be trying one throwing function. (Since `doTry` accepts an `@autoClosure`, this makes it very cumbersome to 
accidentally try more than one throwing function.)
This means that we know exactly what triggered our catch block. 

## Beta: Request for Feedback
This library is currently in beta development and is not API stable. The API may change in the future without notice.

Please report any issues you find. In particular, I'm interested in your feedback on the API design. Also, the library supports typed and untyped errors, sync and async functions. Because of this there are many overloaded functions and generic types. Please let me know if the compiler infers an unexpected overload of a function, or if a type inference is missing.

## Known Issues
### Error Type Inference
It seems the Swift compiler is not able to infer the error type in some cases. Unfortunately, this severely impacts the ergonomics of the library.
For example, the following code will not compile: 
```swift
struct MyStruct: Sendable {
    var int: Int
    enum Error: Swift.Error, Equatable, Sendable {
        case one, two, three, four
    }
    mutating func typedThrowing() throws(Self.Error) -> Int {
        throw Error.three
    }
}

func printThrowing() {
    var myStruct = MyStruct(int: 1)
    let result = Result(for: try myStruct.typedThrowing())
    // Error: Generic parameter 'Failure' could not be inferred
}
```

Even though `typedThrowing` has a typed error, and the library's `Result` initializer passes the error type to `Result`'s generic `Failure` type, the compiler is still unable to infer the error type.

As an unfortunate workaround, you can explicitly specify the error type in the `Result` initializer. 
```swift
let result = Result<Int, MyStruct.Error>(for: try myStruct.typedThrowing())
```

This error type inference problem also affects the `Optional` initializer. 
```swift
var myStruct = MyStruct(int: 1)
let typedSucceeding = Optional(
   for: try myStruct.typedSucceeding(),
   catcher: { (error: MyStruct.Error) in
       Issue.record("This should not throw")
   }
)
```

Here, we must explicitly declare the error type in the `catcher` closure or else we lose the type information and Swift will treat it as `any Error`. But we know for certain that the compiler already has the type information because if we explicitly specify the error type then the compiler immediately has the concrete error type without the need for runtime type casting. 

## Please Sherlock This Library
This library seeks to solve language-level problems that really should be solved by the Swift language itself. The best solution I have found so far is this pitch: 

- [Guard-Let-Catch (and If-Let-Catch) to avoid long (nested) do-blocks](https://forums.swift.org/t/guard-let-catch-and-if-let-catch-to-avoid-long-nested-do-blocks/65827)

## License
The library is released under the MIT License. 
