import Foundation

extension Emotion {
    
    var dictionary: [String: Float] {
        var dict = [String: Float]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let key = child.label, let value = child.value as? Float {
                dict[key] = value
            }
        }
        return dict
    }
}
