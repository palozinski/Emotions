import Foundation

enum Result<T> {
    case success(T)
    case error(Error?)
}

extension Result {
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    var value: T? {
        switch self {
        case let .success(value):
            return value
        default:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .error(error):
            return error
        default:
            return nil
        }
    }
}
