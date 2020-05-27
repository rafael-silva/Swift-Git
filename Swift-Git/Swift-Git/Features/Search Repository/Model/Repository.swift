struct Repository {
    
    let totaCount: Int
    let items: [Item]
    
}

extension Repository {
    init(from output: RepositoryPayload) {
        self.init(totaCount: output.total_count, items: output.items.map { Item(from: $0)} )
    }
}
