import Foundation

struct Owner {
    
    let login: String
    let avatarUrl: URL
    
}

extension Owner {
    init(from output: OwnerPayload) {
        self.init(login: output.login, avatarUrl: URL(string: output.avatar_url)!)
    }
}

