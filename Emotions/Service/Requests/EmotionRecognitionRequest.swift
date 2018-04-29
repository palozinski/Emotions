import Foundation
import Alamofire

struct EmotionRecognitionRequest: CustomUploadRequest {
    
    typealias ReturnType = RecognitionResult
    
    var file: File? {
        return File(data: newUser.imageFile,
                    name: "image_file",
                    fileName: "image.jpg",
                    mimeType: "image/jpeg")
    }
    
    var body: [String: Any]? {
        return [
            "api_key": newUser.apiKey!,
            "api_secret": newUser.apiSecret!,
            "return_attributes": newUser.returnAttributes!
        ]
    }
    
    private let newUser: Body
    
    init(newUser: Body) {
        self.newUser = newUser
    }
    
    var headers: [String: String]? {
        return [
            HTTPHeaderKey.contentType.rawValue: "multipart/form-data"
        ]
    }
    
    var path: String {
        return "detect"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var mapper: ((Data) throws -> RecognitionResult) = {
        let decoder = JSONDecoder()
        return try decoder.decode(RecognitionResult.self, from: $0)
    }
    
    struct Body: Codable {
        let apiKey: String?
        let apiSecret: String?
        let imageFile: Data?
        let returnAttributes: String?
        
        private enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case apiSecret = "api_secret"
            case imageFile = "image_file"
            case returnAttributes = "return_attributes"
        }
    }
}
