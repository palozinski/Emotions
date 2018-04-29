import UIKit

extension UIImage {
    
    var png: Data? {
        return UIImageJPEGRepresentation(self, 0.8)
    }
}
