# Command Line Interface for Releasing macOS Apps

This is a template project that you can use to write a command line application that can be run as a macOS app, and released to TestFlight.

Place the code that you want to run in the `MAIN.swift` file, in the body of `func main() async`. The project will run this code from start to finish

### Print to the console
```Swift
print("Hello, world!")
```

### Clear the console
```Swift
clear()
```

### Clear the console, and immediately replace it with new material
```Swift
replace(with: "Hello again!")
```

### Wait for the user to type in some input, and return if valid, or nil if invalid
```Swift
let string = await readString()
let int = await readInt()
let double = await readDouble()
let bool = await readBool()
```

### Wait for the user to press a key from a set of keys, and then continue
```Swift
let key = await awaitKeyPress(keys: [.w, .a, .s, .d])
switch key {
case .w: print("w")
case .a: print("a")
case .s: print("a")
case .d: print("d")
default: break
}
```

###
```Swift

```
