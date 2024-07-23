import Foundation

class Node {
    var x: Int
    var y: Int
    var previous: Node?
    
    init(x: Int, y: Int, previous: Node? = nil) {
        self.x = x
        self.y = y
        self.previous = previous
    }
}
