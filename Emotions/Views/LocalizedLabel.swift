import UIKit

class LocalizedLabel: UILabel {
    
    @IBInspectable var localizedKey: String? {
        didSet {
            populateLocalization()
        }
    }
    
    private func populateLocalization() {
        guard let localizedKey = localizedKey else {
            return
        }
        text = NSLocalizedString(localizedKey, comment: localizedKey)
    }
}
