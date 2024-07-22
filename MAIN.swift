import Foundation

extension CommandLineManager {
    func main() async {
        // Below are some built-in functions that you can use to interact with the command line UI.
        
        // print - prints to console
        print("Enter your name:")
        
        // readString - user inputs string, then presses return
        let name = await readString()
        print("Your name is \(name)")
        
        // other input methods - returns data type if user inputs correctly, or nil if they don't
        let _ = await readInt()
        let _ = await readDouble()
        let _ = await readBool()
        
        // awaitKeyPress = awaits one or more keys, returns key that was pressed
        await awaitKeyPress(keys: [.leftArrow])
        print("You pressed left arrow")
        
        let key = await awaitKeyPress(keys: [.w, .a, .s, .d])
        switch key {
        case .w: print("w")
        case .a: print("a")
        case .s: print("a")
        case .d: print("d")
        default: break
        }
    }
}
