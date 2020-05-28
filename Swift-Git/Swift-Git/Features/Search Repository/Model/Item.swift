import Foundation
struct Item {
    
    let name: String
    let fullName: String
    let owner: Owner
    let score: Double
    
}

extension Item {
    init(from output: ItemPayload) {
        self.init(name: output.name, fullName: output.full_name, owner: Owner(from: output.owner), score: output.score)
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&
        lhs.fullName == rhs.fullName &&
        lhs.owner == rhs.owner &&
        lhs.score == rhs.score
    }
}

