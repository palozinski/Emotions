struct FaceRectangle: Codable {
    var width: Int
    var top: Int
    var left: Int
    var height: Int
}

struct Emotion: Codable {
    var sadness: Float
    var neutral: Float
    var disgust: Float
    var anger: Float
    var surprise: Float
    var fear: Float
    var happiness: Float
}

struct Attribute: Codable {
    var emotion: Emotion
}

struct Faces: Codable {
    var attributes: Attribute
    var faceRectangle: FaceRectangle
    var faceToken: String
    
    private enum CodingKeys: String, CodingKey {
        case attributes
        case faceRectangle = "face_rectangle"
        case faceToken = "face_token"
    }
}

struct RecognitionResult: Codable {
    var imageId: String
    var requestId: String
    var timeUsed: Int
    var faces: [Faces]
    
    private enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case requestId = "request_id"
        case timeUsed = "time_used"
        case faces
    }
}
