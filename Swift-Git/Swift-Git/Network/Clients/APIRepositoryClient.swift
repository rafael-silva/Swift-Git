protocol APIRepositoryProviderProtocol: AnyObject {
    func repositories(language: String, sort: String, page: Int, completion: @escaping (ReturnOutput<RepositoryPayload>) -> Void)
}

extension API: APIRepositoryProviderProtocol {

    func repositories(language: String, sort: String, page: Int, completion: @escaping (ReturnOutput<RepositoryPayload>) -> Void) {
        API().request(APIRouter.repositories(language: language, sort: sort, page: page), completion: completion)
    }
}
