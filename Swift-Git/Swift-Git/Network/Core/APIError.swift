enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case unknownError(String)   //No mapped error
    
    var description: String {
        switch self {
        case .forbidden:
            return "Forbidden error."
        case .notFound:
            return "The not found failed."
        case .conflict:
            return "Conflict error."
        case .internalServerError:
            return "Internal server error."
        case .unknownError:
            return "Unknown server error."
        }
    }
}
