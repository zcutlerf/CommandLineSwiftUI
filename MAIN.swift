import Foundation

extension CommandLineManager {
    func main() async {
        var wantsToPlaySnake = true
        
        while wantsToPlaySnake {
            replace(with: "Welcome to Snake!")
            print("How big of a board? S/M/L")
            
            var width = 0
            var height = 0
            var initialPosition = (0, 0)
            var direction = Direction.left
            var initialLength = 0
            
            let boardSize = await awaitKeyPress(keys: [.s, .m, .l])
            switch boardSize {
            case .s:
                width = 25
                height = 14
                initialPosition = (4, 4)
                direction = .left
                initialLength = 2
            case .m:
                width = 35
                height = 20
                initialPosition = (6, 6)
                direction = .left
                initialLength = 3
            case .l:
                width = 50
                height = 28
                initialPosition = (8, 8)
                direction = .left
                initialLength = 4
            default:
                fatalError()
            }
            
            
            let game = Game(width: width, height: height, initialPosition: initialPosition, trailing: direction, by: initialLength)
            
            let speed: TimeInterval = 0.1
            
            while !game.gameIsOver {
                let board = game.board
                replace(with: board)
                
                let initialDate = Date()
                let key = await self.awaitKeyPress(keys: Key.arrowKeys, timeout: speed)
                switch key {
                case .upArrow:
                    if game.direction != .down {
                        game.direction = .up
                    }
                case .downArrow:
                    if game.direction != .up {
                        game.direction = .down
                    }
                case .leftArrow:
                    if game.direction != .right {
                        game.direction = .left
                    }
                case .rightArrow:
                    if game.direction != .left {
                        game.direction = .right
                    }
                default:
                    break
                }
                
                let currentDate = Date()
                let timeNotUsed = speed - currentDate.timeIntervalSince(initialDate)
                
                if speed > 0 {
                    try? await Task.sleep(for: .seconds(timeNotUsed))
                }
                
                game.advance()
            }
            
            print("Game Over :'(")
            print("Play again? Y/N")
            let key = await awaitKeyPress(keys: [.y, .n])
            switch key {
            case .n:
                wantsToPlaySnake = false
            default:
                break
            }
        }
    }
}
