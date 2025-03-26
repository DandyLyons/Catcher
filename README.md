# Catcher

Stop fighting with Swift's frustrating do-catch blocks. Catch errors simply. 

This library provides strategies to run throwing functions without: 
1. creating a `throws` context
2. creating a `do` `catch` block

## Usage
Catch and handle your errors simply and ergonomically by: 
1. replacing the error with a reasonable value
2. bundling the error and value in a `Result`
3. simply handling the error in place

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

## License
The library is released under the MIT License. 
