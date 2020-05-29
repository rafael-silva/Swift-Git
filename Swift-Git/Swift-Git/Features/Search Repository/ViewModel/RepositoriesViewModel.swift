import Foundation

protocol RepositoriesViewModelProtocol {
    var repositories: Dynamic<[Item]?> { get }
    var error: Dynamic<String?> { get }
    
    var isFetchInProgress: Bool { get }
    var currentPage: Int { get }
    
    func numberOfRows() -> Int
    func loadRepositories()
}

final class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private(set) var repositories: Dynamic<[Item]?> = Dynamic(nil)
    private(set) var error: Dynamic<String?> = Dynamic(nil)
    private let api: APIRepositoryProviderProtocol
    
    private(set) var currentPage = 1
    
    private(set) var items: [Item] = [] {
        didSet {
            repositories.value = items
        }
    }
    
    private(set) var isFetchInProgress = false
    
    init(api: APIRepositoryProviderProtocol = API()) {
        self.api = api
    }
    
    func loadRepositories() {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        api.repositories(language: "swift", sort: "stars", page: currentPage) { response in
            switch response {
            case.success(let output):
                
                self.currentPage += 1
                self.isFetchInProgress = false
                
                self.items.append(contentsOf: Repository.init(from: output).items)
            case.failure(let error):
                
                self.error.value = error.description
                self.isFetchInProgress = false
            }
        }
    }
    
}

extension RepositoriesViewModel {
    
    func numberOfRows() -> Int {
        items.count - 1
    }
    
}
