import UIKit

class LocalizedButton: UIButton {
    
    @IBInspectable var localizedKey: String? {
        didSet {
            populateLocalization()
        }
    }
    
    func populateLocalization() {
        guard let localizedKey = localizedKey else {
            return
        }
        let title = NSLocalizedString(localizedKey, comment: localizedKey)
        setTitle(title, for: .normal)
    }
}
