protocol RepositoriesViewModelProtocol {
    var repositories: Dynamic<[Item]?> { get }
    var error: Dynamic<String?> { get }
}

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private(set) var repositories: Dynamic<[Item]?> = Dynamic(nil)
    private(set) var error: Dynamic<String?> = Dynamic(nil)

    init(api: APIRepositoryProviderProtocol = API()) {
        api.repositories(language: "swift", sort: "stars") { response in
            switch response {
            case.success(let output):
                self.repositories.value = output.items.map { Item(from: $0) }
            case.failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
