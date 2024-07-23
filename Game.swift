import Foundation

class Game {
    let width: Int
    let height: Int
    var head: Node
    var direction = Direction.right
    var treats: [(id: UUID, x: Int, y: Int)] = []
    var gameIsOver = false
    
    init(width: Int, height: Int, initialPosition: (x: Int, y: Int), trailing direction: Direction, by length: Int) {
        self.width = width
        self.height = height
        
        head = Node(x: initialPosition.x, y: initialPosition.y)
        var currentNode = head
        for _ in 0..<length {
            let newNode = Node(x: currentNode.x + direction.incrementAmount.x, y: currentNode.y + direction.incrementAmount.y)
            currentNode.previous = newNode
            currentNode = newNode
        }
        self.direction = direction.opposite
        
        // TODO: better treat logic
        for _ in 1...30 {
            treats.append(
                (id: UUID(), x: Int.random(in: 0..<width), y: Int.random(in: 0..<height))
            )
        }
    }
    
    var snake: [(id: Int, x: Int, y: Int)] {
        var current = head
        var allCoordinates = [(0, current.x, current.y)]
        var number = 1
        while let previous = current.previous {
            allCoordinates.append((number, previous.x, previous.y))
            current = previous
            number += 1
        }
        return allCoordinates.reversed()
    }
    
    func advance() {
        move(direction)
        
        if !(0..<width ~= head.x) || !(0..<height ~= head.y) {
            gameIsOver = true
        }
        
        if snake[0..<snake.count - 1].contains(where: { coordinate in
            head.x == coordinate.x
            && head.y == coordinate.y
        }) {
            gameIsOver = true
        }
        
        if isOnTreat {
            treats.removeAll { treat in
                treat.x == head.x
                && treat.y == head.y
            }
        } else {
            deleteEnd(head)
        }
    }
    
    func reset(initialPosition: (x: Int, y: Int), trailing direction: Direction, by length: Int) {
        treats.removeAll()
        
        head = Node(x: initialPosition.x, y: initialPosition.y)
        var currentNode = head
        for _ in 0..<length {
            let newNode = Node(x: currentNode.x + direction.incrementAmount.x, y: currentNode.y + direction.incrementAmount.y)
            currentNode.previous = newNode
            currentNode = newNode
        }
        self.direction = direction.opposite
        
        // TODO: better treat logic
        for _ in 1...30 {
            treats.append(
                (id: UUID(), x: Int.random(in: 0..<width), y: Int.random(in: 0..<height))
            )
        }
        
        gameIsOver = false
    }
    
    private func move(_ direction: Direction) {
        let incrementAmount = direction.incrementAmount
        let newX = head.x + incrementAmount.x
        let newY = head.y + incrementAmount.y
        let newHead = Node(x: newX, y: newY, previous: head)
        self.head = newHead
    }
    
    private func deleteEnd(_ node: Node? = nil) {
        if let previousPrevious = node?.previous?.previous {
            deleteEnd(previousPrevious)
        } else {
            node?.previous = nil
        }
    }
    
    private var isOnTreat: Bool {
        treats.contains(where: { treat in
            treat.x == head.x
            && treat.y == head.y
        })
    }
    
    var board: String {
        var board = Array(repeating: Array(repeating: " ", count: width), count: height)
        
        for treat in treats {
            board[treat.y][treat.x] = "*"
        }
        
        for segment in snake {
            board[segment.y][segment.x] = "0"
        }
        
        return " " + String(Array(repeating: "–", count: width)) + " \n"
        + board.map { row in
            "|" + row.joined() + "|"
        }.joined(separator: "\n")
        + "\n " + String(Array(repeating: "–", count: width)) + " "
    }
}
