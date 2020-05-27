import Foundation

struct ItemPayload: Decodable {
    
    let id: Int
    let node_id: String
    let name: String
    let full_name: String
    let `private`: Bool
    let owner: OwnerPayload
    let html_url: String
    let description: String
    let fork: Bool
    let url: String
    let created_at: String
    let updated_at: String
    let pushed_at: String
    let homepage: String?
    let size: Int
    let stargazers_count: Int
    let watchers_count: Int
    let language: String
    let forks_count: Int
    let open_issues_count: Int
    let master_branch: String?
    let default_branch: String
    let score: Int
    
}
