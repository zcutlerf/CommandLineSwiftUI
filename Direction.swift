import Foundation

enum Direction {
    case up, right, down, left
    
    var incrementAmount: (x: Int, y: Int) {
        switch self {
        case .up:
            (0, -1)
        case .right:
            (1, 0)
        case .down:
            (0, 1)
        case .left:
            (-1, 0)
        }
    }
    
    var opposite: Direction {
        switch self {
        case .up:
                .down
        case .right:
                .left
        case .down:
                .up
        case .left:
                .right
        }
    }
}
