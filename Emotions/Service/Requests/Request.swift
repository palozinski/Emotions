import Foundation
import Alamofire

protocol CustomUploadRequest {
    associatedtype ReturnType
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var mapper: ((Data) throws -> ReturnType) { get }
    var body: [String: Any]? { get }
    var file: File? { get }
}
