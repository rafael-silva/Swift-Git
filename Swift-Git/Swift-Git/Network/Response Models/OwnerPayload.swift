import Foundation

struct OwnerPayload: Decodable {
    
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let received_events_url: String
    let type: String
    
}
