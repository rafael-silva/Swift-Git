struct Repository {
    
    let totaCount: Int
    let items: [Item]
    
}

extension Repository {
    init(from output: RepositoryPayload) {
        self.init(totaCount: output.total_count, items: output.items.map { Item(from: $0)} )
    }
}

extension Repository: Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.totaCount == rhs.totaCount &&
        lhs.items == rhs.items
    }
}
