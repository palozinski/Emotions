import Foundation
import UIKit

enum EmotionError {
    case noFaceDetected
}

final class EmotionsRecognizerContainerViewModel {
    
    private let service: EmotionsRecognitionService
    
    init(service: EmotionsRecognitionService) {
        self.service = service
    }
    
    func recognize(image: UIImage?,
                   returnAttributes: FaceRecognitionType,
                   completion: @escaping ([String: Float]?, EmotionError?) -> Void) {
        
        guard let imageFile = image?.png else {
            return
        }
        service.perform(imageFile: imageFile, returnAttributes: returnAttributes.rawValue) {
            guard let emotion = $0.value?.faces.first?.attributes.emotion,
                !emotion.dictionary.isEmpty else {
                completion(nil, .noFaceDetected)
                return
            }
            completion(emotion.dictionary, nil)
        }
    }
}
