struct Constants {
    static let baseUrl = "https://api.github.com"
    
    struct Parameters {
        static let repositories = "repositories"
        static let language = "language"
        static let sort = "sort"
        static let q = "q"
        static let page = "page"
        static let perPage = "per_page"
    }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

