import Foundation
import Alamofire

internal enum APIRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    
    case repositories(language: String, sort: String)
    
    //MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    ///This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    
    private var method: HTTPMethod {
        switch self {
        case .repositories:
            return .get
        }
    }
    
    //MARK: - Path
    ///The path is the part following the base url
    
    private var path: String {
        switch self {
        case .repositories:
            return "search/repositories"
        }
    }
    
    //MARK: - Parameters
    ///This is the queries part, it's optional because an endpoint can be without parameters
    
    private var parameters: Parameters? {
        switch self {
        case .repositories(let language, let sort):
            return [Constants.Parameters.q: "language:\(language)",
                    Constants.Parameters.sort: sort]

        }
    }
}
