import Foundation

enum ServiceError: String, Error {
    case unknown = "unknown_server_error"
}

extension Array: Error where Element == String {}

extension Data {
    
    func array() -> [String]? {
        guard let errors = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return nil
        }
        let dict = errors?["errors"] as? [String: AnyObject?]
        return dict?.filter { $0.value != nil }.compactMap { "\($0.key) - \($0.value!)" }
    }
}
