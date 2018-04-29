import Foundation

final class EmotionsRecognitionService {
    
    private let apiKey: String
    private let apiSecret: String
    private let service: ServiceProtocol
    
    init(apiKey: String,
         apiSecret: String,
         service: ServiceProtocol) {
        self.apiKey = apiKey
        self.apiSecret = apiSecret
        self.service = service
    }
    
    func perform(imageFile: Data,
                 returnAttributes: String,
                 completion: @escaping ((Result<RecognitionResult>) -> Void)) {
        
        let body = EmotionRecognitionRequest.Body(apiKey: apiKey, apiSecret: apiSecret,
                                                  imageFile: imageFile, returnAttributes: returnAttributes)
        let request = EmotionRecognitionRequest(newUser: body)
        service.upload(request: request) {
            completion($0)
        }
    }
}
