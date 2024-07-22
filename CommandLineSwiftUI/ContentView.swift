import SwiftUI

struct ContentView: View {
    @StateObject private var manager = CommandLineManager()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        List {
            ForEach(manager._lines) { line in
                Text(line.text)
                    .font(.system(.body).monospaced())
                    .listRowSeparator(.hidden)
            }
            
            if manager._isAwaitingUserInput {
                HStack(spacing: 2) {
                    Text(manager._userInput)
                        .font(.system(.body).monospaced())
                    
                    Text("▮")
                        .font(.system(.title2).monospaced())
                }
                .listRowSeparator(.hidden)
            }
            
            if manager._hasFinishedRunningMain {
                Text("Program ended with exit code: 0")
                    .font(.system(.body).monospaced())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                await manager.main()
                await MainActor.run {
                    manager._hasFinishedRunningMain = true
                }
            }
            
            enableDeleteKey()
        }
        .focusable()
        .focused($isFocused)
        .focusEffectDisabled()
        .onKeyPress(.return) {
            Task {
                await MainActor.run {
                    manager._isAwaitingUserInput = false
                }
            }
            return .handled
        }
        .onKeyPress(characters: .alphanumerics) { keyPress in
            if manager._isAwaitingUserInput {
                Task {
                    await MainActor.run {
                        manager._userInput.append(keyPress.characters)
                    }
                }
                return .handled
            } else {
                return .ignored
            }
        }
        .onKeyPress(phases: .down) { keyPress in
            if let key = Key(keyEquivalent: keyPress.key) {
                if manager._awaitingKeyPresses.contains(key) {
                    Task {
                        await MainActor.run {
                            manager._pressedKey = key
                            manager._isAwaitingKeyPresses = false
                        }
                    }
                    return .handled
                }
            }
            return .ignored
        }
    }
    
    func enableDeleteKey() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.specialKey == .delete {
                if manager._isAwaitingUserInput && !manager._userInput.isEmpty {
                    Task {
                        await MainActor.run {
                            manager._userInput.removeLast()
                        }
                    }
                } else if manager._isAwaitingKeyPresses && manager._awaitingKeyPresses.contains(.delete) {
                    Task {
                        await MainActor.run {
                            manager._pressedKey = .delete
                            manager._isAwaitingKeyPresses = false
                        }
                    }
                }
            }
            return event
        }
    }
}

#Preview {
    ContentView()
}
