import UIKit

protocol RepositoryCellViewModelProtocol {
    var repositoryIcon: Dynamic<UIImage> { get }
    var repositoryTitle: Dynamic<String?> { get }
    var repositoryStar: Dynamic<UIImage> { get }
    var repositoryStars: Dynamic<Double?> { get }
    var ownerName: Dynamic<String?> { get }
    var ownerAvatar: Dynamic<URL?> { get }
    var isLoading: Dynamic<Bool?> { get }
    var propertiesAlpha: Dynamic<CGFloat?> { get }
}

final class RepositoryCellViewModel: RepositoryCellViewModelProtocol {
    
    private(set) var repositoryIcon: Dynamic<UIImage> = Dynamic(#imageLiteral(resourceName: "repositoryIcon"))
    private(set) var repositoryStar: Dynamic<UIImage> = Dynamic(#imageLiteral(resourceName: "starIcon"))
    private(set) var repositoryTitle: Dynamic<String?> = Dynamic(nil)
    private(set) var repositoryStars: Dynamic<Double?> = Dynamic(nil)
    private(set) var ownerName: Dynamic<String?> = Dynamic(nil)
    private(set) var ownerAvatar: Dynamic<URL?> = Dynamic(nil)
    private(set) var isLoading: Dynamic<Bool?> = Dynamic(nil)
    private(set) var propertiesAlpha: Dynamic<CGFloat?> = Dynamic(nil)

    init(repository: Item?) {
        if let repository = repository {
            isLoading.value = false
            propertiesAlpha.value = 1
            repositoryTitle.value = repository.fullName
            repositoryStars.value = Double(repository.score)
            ownerName.value = repository.owner.login
            
            guard let avatarUrl = URL(string: repository.owner.avatarUrl) else { return }
            ownerAvatar.value = avatarUrl
            
        } else {
            isLoading.value = true
            propertiesAlpha.value = 0
        }
    }
}
