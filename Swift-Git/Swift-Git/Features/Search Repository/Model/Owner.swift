struct Owner {
    
    let login: String
    let avatarUrl: String
    
}

extension Owner {
    init(from output: OwnerPayload) {
        self.init(login: output.login, avatarUrl: output.avatar_url)
    }
}

