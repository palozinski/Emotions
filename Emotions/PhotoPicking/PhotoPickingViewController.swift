import UIKit

protocol PhotoPickingViewControllerDelegate: class {
    func didFinishPicking(with image: UIImage)
}

final class PhotoPickingViewController: UIViewController,
                                        UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate {
    
    weak var delegate: PhotoPickingViewControllerDelegate?
    
    // MARK: - Actions
    
    @IBAction func takePhotoFromCameraRoll(_ sender: LocalizedButton) {
        takePhoto(fromSource: .photoLibrary)
    }
    
    @IBAction func takePhoto(_ sender: LocalizedButton) {
        takePhoto(fromSource: .camera)
    }
    
    // MARK: - Image picker Controller Delegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        delegate?.didFinishPicking(with: image)
        dismiss(animated: true)
    }
    
    private func takePhoto(fromSource source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}
