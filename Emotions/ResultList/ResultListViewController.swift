import UIKit

final class ResultListViewController: UIViewController {
    
    // MARK: Injected
    
    var dataSource: ResultListSataSource?
    
    // MARK: Outlets
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            dataSource?.tableView = tableView
        }
    }
}
