import Foundation

class CommandLineManager: ObservableObject {
    /// List of lines shown on the command line UI.
    @Published var _lines: [Line] = [Line(text: "Welcome to the Command Line!", number: 0)]
    
    /// The currently selected line number.
    /// (Usually the last line on the command line UI)
    @Published var _currentLine: Int = 0
    
    /// Whether we are waiting for the user to type something in.
    @Published var _isAwaitingUserInput = false
    
    /// The input that the user is typing, before they have pressed return.
    /// (After they press return, their input will be added to `lines`.
    @Published var _userInput = ""
    
    /// Whether the `main()` method of `CommandLineManager` has finished running.
    /// (When this becomes `true`, display some sort of indication that the program has "finished".
    @Published var _hasFinishedRunningMain = false
    
    /// Whether we are waiting for the user to press some keys.
    @Published var _isAwaitingKeyPresses = false
    
    /// The keys we are waiting for the user to press.
    @Published var _awaitingKeyPresses: [Key] = []
    
    /// The key the user has pressed, if it matches one of the key presses available.
    @Published var _pressedKey: Key?
    
    /// Prints any number of items to the command line UI.
    /// Multiple items will be separated by a space by default.
    func print(_ items: CustomStringConvertible..., separator: String = " ") {
        var text = ""
        for item in items {
            text.append(item.description)
        }
        
        let staticText = text
        Task {
            await MainActor.run {
                _lines.append(Line(text: staticText, number: _currentLine + 1))
                _currentLine += 1
            }
        }
    }
    
    /// Reads a string inputted by the user from the command line UI.
    /// - Returns: String typed by the user.
    func readString() async -> String {
        await MainActor.run {
            _isAwaitingUserInput = true
        }
        
        while _isAwaitingUserInput {
            await Task.yield()
        }
        
        let text = _userInput
        await MainActor.run {
            _lines.append(Line(text: text, number: _currentLine + 1))
            _currentLine += 1
            _userInput = ""
        }
        return text
    }
    
    /// Reads a string inputted by the user from the command line UI.
    /// - Returns: String typed by the user.
    func readLine() async -> String? {
        await readString()
    }
    
    /// Reads an integer inputted by the user from the command line UI.
    /// - Returns: Int typed by the user, or  nil if they input something other than an integer.
    func readInt() async -> Int? {
        Int(await readString())
    }
    
    /// Reads a double inputted by the user from the command line UI.
    /// - Returns: Double typed by the user, or  nil if they input something other than a double.
    func readDouble() async -> Double? {
        Double(await readString())
    }
    
    /// Reads a boolean inputted by the user from the command line UI.
    /// - Returns: Bool typed by the user, or nil if they input something other than a boolean.
    func readBool() async -> Bool? {
        Bool(await readString())
    }
    
    /// Waits for the user to press a key.
    /// - Parameter keys: The keys being watched.
    /// - Returns: The key pressed by the user.
    @discardableResult
    func awaitKeyPress(keys: [Key]) async -> Key {
        await MainActor.run {
            _isAwaitingKeyPresses = true
            _awaitingKeyPresses = keys
        }
        
        while _isAwaitingKeyPresses {
            await Task.yield()
        }
        
        let pressedKey = _pressedKey
        await MainActor.run {
            _awaitingKeyPresses = []
            self._pressedKey = nil
        }
        
        return pressedKey!
    }
    
    /// Clears the command line UI.
    func clear() {
        Task {
            await MainActor.run {
                _currentLine = 0
                _lines = [Line(text: "Welcome to the Command Line!", number: 0)]
            }
        }
    }
}
