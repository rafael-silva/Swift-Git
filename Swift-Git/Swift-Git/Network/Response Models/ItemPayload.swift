import Foundation

struct ItemPayload: Decodable {
    
    let name: String
    let full_name: String
    let owner: OwnerPayload
    let score: Double
    
}
