import UIKit

final class ResultTableViewCell: UITableViewCell {
    
    var value: Float? {
        didSet {
            emotionValueLabel.text = NumberFormatters
                .longFraction.string(from: NSNumber(value: value ?? 0))
        }
    }
    
    var name: String? {
        didSet {
            emotionNameLabel.text = name?.localized
        }
    }
    
    @IBOutlet private var emotionNameLabel: LocalizedLabel!
    @IBOutlet private var emotionValueLabel: LocalizedLabel!
}
