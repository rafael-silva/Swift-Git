import Foundation

struct RepositoryPayload: Decodable {
    
    let total_count: Int
    let incomplete_results: Bool
    let items: [ItemPayload]
    
}
