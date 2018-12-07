import UIKit

final class ResultListSataSource: NSObject, UITableViewDataSource {
    
    private var emotions: [String: Float]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private var emotionsNames: [String] {
        return emotions?.map { $0.key } ?? []
    }
    
    private var emotionsValues: [Float] {
        return emotions?.map { $0.value } ?? []
    }
    
    var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            NotificationCenter.default
                .addObserver(self,
                             selector: #selector(updateView(_:)),
                             name: Notification.Name("EmotionsDataChanged"),
                             object: nil)
        }
    }
    
    @objc private func updateView(_ notification: Notification) {
        guard let emotions = notification.object as? [String: Float] else {
            return
        }
        self.emotions = emotions
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "cell") as? ResultTableViewCell else {
                fatalError()
        }
        cell.name = emotionsNames[indexPath.item]
        cell.value = emotionsValues[indexPath.item]
        return cell
    }
}
