import Quick
import Nimble

@testable import Swift_Git

class RepositoriesViewModelTests: QuickSpec {
    
    enum State {
        case success
        case fail
    }
    
    override func spec() {
        
        var spyApi: APIRepositoryProviderSpy!
        var sut_viewModel: RepositoriesViewModel!
        
        describe("MoviesUpcomingPresenter") {
            
            func setup(state: State = .fail, error: ApiError = .unknownError("teste")) {
                spyApi = APIRepositoryProviderSpy(state: state, error: error)
                sut_viewModel = RepositoriesViewModel(api: spyApi)
            }
            
            beforeEach {
                setup()
            }
            
            describe("when call fetch repositories called") {
                
                context("and the request was completed with repository") {
                   
                    it("then should bind repositories to presentation") {
                        sut_viewModel.loadRepositories()
                        setup(state: .success)
                        
                        let mock = Repository(totaCount: 1, items: [Item(name: "teste", fullName: "teste name", owner: Owner(login: "login", avatarUrl: URL(string: "avatar.com")!), score: 1.2)])
                        expect(sut_viewModel.repository.value).to(equal(mock))
                    }
                }
                
                context("and return error 500") {
                    
                    it("then should bind error to presentantion") {
                        sut_viewModel.loadRepositories()
                        setup(state: .fail, error: .internalServerError)
                        
                        expect(sut_viewModel.error.value) == "Internal server error."
                    }
                }
                
                context("and return error 409") {
                    
                    it("then should bind error to presentantion") {
                        sut_viewModel.loadRepositories()
                        setup(state: .fail, error: .conflict)
                        
                        expect(sut_viewModel.error.value) == "Conflict error."
                    }
                }
                
                context("and return error 404") {
                    
                    it("then should bind error to presentantion") {
                        sut_viewModel.loadRepositories()
                        setup(state: .fail, error: .notFound)
                        
                        expect(sut_viewModel.error.value) == "The not found failed."
                    }
                }
                
                context("and return error 403") {
                    
                    it("then should bind error to presentantion") {
                        sut_viewModel.loadRepositories()
                        setup(state: .fail, error: .forbidden)
                        
                        expect(sut_viewModel.error.value) == "Forbidden error."
                    }
                }
                
                context("and return unknown server error") {
                    
                    it("then should bind error to presentantion") {
                        sut_viewModel.loadRepositories()
                        setup(state: .fail, error: .unknownError("Unknown server error."))
                        
                        expect(sut_viewModel.error.value) == "Unknown server error."
                    }
                }
                
            }
        }
    }
}

private class APIRepositoryProviderSpy: APIRepositoryProviderProtocol {
 
    private let state: RepositoriesViewModelTests.State
    var repository: RepositoryPayload?
    var error: ApiError
    
    init(state: RepositoriesViewModelTests.State, error: ApiError) {
        self.state = state
        self.error = error
    }
    
    func repositories(language: String, sort: String, page: Int, completion: @escaping (ReturnOutput<RepositoryPayload>) -> Void) {
        switch state {
        case .success:
            completion(.success(.dummy))
        case .fail:
            completion(.failure(error))
        }
    }
}

extension RepositoryPayload {
    static var dummy: RepositoryPayload = {
        return RepositoryPayload(total_count: 1, incomplete_results: true, items: [ItemPayload.dummyItem])
    }()
}

extension ItemPayload {
    static var dummyItem: ItemPayload = {
        return ItemPayload(name: "teste", full_name: "teste name", owner: OwnerPayload.dummyOwner, score: 1.2)
    }()
}

extension OwnerPayload {
    static var dummyOwner: OwnerPayload = {
        return OwnerPayload(login: "login", id: 1, node_id: "$%!1s", avatar_url: "avatar.com", gravatar_id: "avatar_id", url: "avatar.com", received_events_url: "", type: "user")
    }()
}

