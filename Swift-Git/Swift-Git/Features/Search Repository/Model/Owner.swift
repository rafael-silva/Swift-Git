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

extension Owner: Equatable {
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.login == rhs.login &&
        lhs.avatarUrl == rhs.avatarUrl
    }
}


