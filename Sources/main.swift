import Foundation

class Room {
    let description: String
    var exits: [String: Room] = [:]

    init(description: String) {
        self.description = description
    }

    func connectRoom(_ room: Room, throughExit exit: String) {
        exits[exit] = room
    }
}

func createDungeon() -> Room {
    let entrance = Room(description: "You are in a dark, cold entrance hall.")
    let hallway = Room(description: "You are standing in a narrow hallway. There's a faint light at the end.")
    let chamber = Room(description: "This is a large chamber with an eerie glow.")
    let treasureRoom = Room(description: "You've found the treasure room! But there's no exit here.")
    let exit = Room(description: "You see daylight! This is the exit!")

    entrance.connectRoom(hallway, throughExit: "forward")
    hallway.connectRoom(chamber, throughExit: "left")
    hallway.connectRoom(exit, throughExit: "right")
    chamber.connectRoom(treasureRoom, throughExit: "forward")
    treasureRoom.connectRoom(chamber, throughExit: "back")

    return entrance
}

func playGame(startingRoom: Room) {
    var currentRoom = startingRoom
    var isGameOver = false

    while !isGameOver {
        print(currentRoom.description)

        if currentRoom.exits.isEmpty {
            print("Congratulations, you've escaped the dungeon!")
            isGameOver = true
            continue
        }

        print("Exits:")
        for (exit, _) in currentRoom.exits {
            print(exit)
        }

        print("Enter your move (or 'exit' to quit): ", terminator: "")
        if let move = readLine()?.lowercased(), !move.isEmpty {
            if move == "exit" {
                isGameOver = true
            } else if let nextRoom = currentRoom.exits[move] {
                currentRoom = nextRoom
            } else {
                print("You can't go that way.")
            }
        }
    }
}

// Start the game
let startingRoom = createDungeon()
playGame(startingRoom: startingRoom)
