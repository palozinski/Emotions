import UIKit

struct InfoConfig {
    
    enum Property: String {
        case endpointBase = "EndpointBase"
        case faceppApiKey = "FaceppApiKey"
        case faceppApiSecret = "FaceppApiSecret"
    }
    
    let bundle: Bundle
    
    func value<T>(for key: Property) -> T {
        guard let value = bundle.infoDictionary?[key.rawValue] as? T else {
            fatalError("Error reading config key '\(key)'")
        }
        return value
    }
}
