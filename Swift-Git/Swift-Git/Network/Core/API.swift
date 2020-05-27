import Alamofire

protocol APIProvider: AnyObject {
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible,
                               completion: @escaping (Result<T, ApiError>) -> Void)
}

class API: APIProvider {
    
    init() {}
    
    internal func request<T: Decodable>(_ urlConvertible: URLRequestConvertible,
                               completion: @escaping (Result<T, ApiError>) -> Void)  {
        AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                switch response.response?.statusCode {
                case 403:
                    completion(.failure(ApiError.forbidden))
                case 404:
                    completion(.failure(ApiError.notFound))
                case 409:
                    completion(.failure(ApiError.conflict))
                case 500:
                    completion(.failure(ApiError.internalServerError))
                default:
                    completion(.failure(ApiError.unknownError(error.localizedDescription)))
                }
            }
        }
    }
}

