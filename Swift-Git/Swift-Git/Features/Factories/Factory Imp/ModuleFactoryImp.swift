import UIKit

final class ModuleFactoryImp: RepositoryFactory {
   
    func makeRepositoriesOutput() -> RepositoriesViewController {
        let viewModel = RepositoriesViewModel()
        let view = RepositoriesViewController(viewModel: viewModel)
        
        return view
    }
}
