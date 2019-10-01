//
//  Board.swift
//  Fifteen
//
//  Created by Damon Cricket on 30.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import Foundation

enum Position: Int {
    
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen
    case sixteen
}

enum Bone: Int {
    
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen
    case empty
}

struct Board {
    
    private(set) var bones: [Position: Bone] = [:]

    func line(forBone bone: Bone) -> Int {
        var position: Position = .one
        for (ps, bn) in bones {
            if bone == bn {
                position = ps
            }
        }
        
        if position.rawValue >= 1 && position.rawValue <= 4 {
            return 0
        } else if position.rawValue >= 5 && position.rawValue <= 8 {
            return 1
        } else if position.rawValue >= 9 && position.rawValue <= 12 {
            return 2
        } else {
            return 3
        }
    }
    
    func column(forBone bone: Bone) -> Int {
        var position: Position = .one
        for (ps, bn) in bones {
            if bone == bn {
                position = ps
            }
        }
        
        if position == .one || position == .five || position == .nine || position == .thirteen {
            return 0
        } else if position == .two || position == .six || position == .ten || position == .fourteen {
            return 1
        } else if position == .three || position == .seven || position == .eleven || position == .fifteen {
            return 2
        } else {
            return 3
        }
    }
    
    mutating func random() {
        bones.removeAll()
        for idx in 1...16 {
            let position = Position(rawValue: idx)!
            let value = randomValue()
            bones[position] = value
        }
    }
    
    func isSolved() -> Bool {
        for idx in 1...16 {
            let position = Position(rawValue: idx)!
            if bones[position] != Bone(rawValue: idx)! || bones[position] != .empty {
                return false
            }
        }
        return true
    }
    
    mutating func move(bone: Bone) {
        if canMove(bone: bone) {
            let position = bones.position(whereBone: bone)
            if let left = Position(rawValue: position.rawValue - 1), bones[left] == .empty {
                let sw = bones[position]
                bones[position] = bones[left]
                bones[left] = sw
            } else if let up = Position(rawValue: position.rawValue - 4), bones[up] == .empty {
                let sw = bones[position]
                bones[position] = bones[up]
                bones[up] = sw
            } else if let right = Position(rawValue: position.rawValue + 1), bones[right] == .empty {
                let sw = bones[position]
                bones[position] = bones[right]
                bones[right] = sw
            } else if let down = Position(rawValue: position.rawValue + 4), bones[down] == .empty {
                let sw = bones[position]
                bones[position] = bones[down]
                bones[down] = sw
            }
        }
    }
    
    func canMove(bone: Bone) -> Bool {
        let position = bones.position(whereBone: bone)
        if let left = Position(rawValue: position.rawValue - 1), bones[left] == .empty {
            return true
        } else if let up = Position(rawValue: position.rawValue - 4), bones[up] == .empty {
            return true
        } else if let right = Position(rawValue: position.rawValue + 1), bones[right] == .empty {
            return true
        } else if let down = Position(rawValue: position.rawValue + 4), bones[down] == .empty {
            return true
        }
        return false
    }
    
    private func randomValue() -> Bone {
        while true {
            let number = Int.random(in: 1...16)
            let value = Bone(rawValue: number)!
            if !bones.contains(where: { $1 == value}) {
                return value
            }
        }
    }
}

private extension Dictionary where Key == Position, Value == Bone {
    func position(whereBone bone: Bone) -> Key {
        for (k, v) in self {
            if v == bone {
                return k
            }
        }
        return .one
    }
}
