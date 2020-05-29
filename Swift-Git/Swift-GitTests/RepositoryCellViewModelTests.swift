import Quick
import Nimble

@testable import Swift_Git

class RepositoryCellViewModelTests: QuickSpec {
    
    override func spec() {
        
        var sut_viewModel: RepositoryCellViewModelProtocol!
        
        describe("MoviesUpcomingPresenter") {
            
            func setup(repository: Item?) {
                sut_viewModel = RepositoryCellViewModel(repository: repository)
            }
            
            describe("when reposytory cell was attached") {
                
                context("and have a repository") {
                    beforeEach {
                        setup(repository: Item.dummy)
                    }
                    
                    it("then should bind properties to presentation") {
                        expect(sut_viewModel.ownerName.value) == "login"
                        expect(sut_viewModel.repositoryStars.value) == 1.2
                        expect(sut_viewModel.repositoryTitle.value) == "teste name"
                        expect(sut_viewModel.repositoryIcon.value) == #imageLiteral(resourceName: "repositoryIcon")
                        expect(sut_viewModel.isLoading.value) == false
                        expect(sut_viewModel.propertiesAlpha.value) == 1
                    }
                }
                
                context("and have a repository") {
                    beforeEach {
                        setup(repository: .none)
                    }
                    
                    it("then should bind properties to presentation") {
                        expect(sut_viewModel.isLoading.value) == true
                        expect(sut_viewModel.propertiesAlpha.value) == 0
                    }
                }
                
                
            }
        }
    }
}

extension Item {
    static var dummy: Item = {
        return Item(name: "teste", fullName: "teste name", owner: Owner.dummy, score: 1.2)
    }()
}

extension Owner {
    static var dummy: Owner = {
        return Owner(login: "login", avatarUrl: URL(string: "avatar.com")!)
    }()
}

