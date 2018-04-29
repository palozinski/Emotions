import UIKit

final class RecognizerContainerViewController: UIViewController,
                                               PhotoPickingViewControllerDelegate {
    
    // MARK: Injected
    
    var viewModel: EmotionsRecognizerContainerViewModel?
    
    // MARK: Outlets
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var primaryButton: LocalizedButton!
    @IBOutlet private var faceImageView: UIImageView!
    
    // MARK: Liecycle
    
    @IBAction func primaryButtonActions(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "try_again".localized:
            cleanView()
        default:
            startRecognition()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? PhotoPickingViewController)?.delegate = self
    }
    
    private func startRecognition() {
        viewModel?.recognize(image: faceImageView.image, returnAttributes: .emotion) { emotion, error in
            guard error == nil else {
                self.presentErrorAler()
                return
            }
            self.presentRecevied(emotions: emotion)
        }
    }
    
    private func cleanView() {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        primaryButton.isHidden = true
        primaryButton.setTitle("RecognizeEmotions", for: .normal)
        faceImageView.image = nil
    }
    
    private func presentRecevied(emotions: [String: Float]?) {
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
        primaryButton.setTitle("try_again".localized, for: .normal)
        NotificationCenter.default.post(name: Notification.Name("EmotionsDataChanged"), object: emotions)
    }
    
    private func presentErrorAler() {
        let alert = UIAlertController(title: "error_title".localized,
                                      message: "error_message".localized,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "ok".localized, style: .default) { _ in
            self.cleanView()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Photo Picking View Controller Delegate
    
    func didFinishPicking(with image: UIImage) {
        faceImageView.image = image
        primaryButton.isHidden = false
    }
}
