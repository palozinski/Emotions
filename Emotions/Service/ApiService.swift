import Foundation
import Alamofire

final class ApiService: ServiceProtocol {
    
    private let base: String
    
    init(base: String) {
        self.base = base
    }
    
    func upload<T: CustomUploadRequest>(request: T,
                                        completion: @escaping ((Result<T.ReturnType>) -> Void)) {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in request.body ?? [:] {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = request.file?.data {
                multipartFormData.append(data, withName: request.file?.name ?? "",
                                         fileName: request.file?.fileName ?? "",
                                         mimeType: request.file?.mimeType ?? "")
            }
            
        }, usingThreshold: UInt64.init(),
           to: base + request.path,
           method: request.method,
           headers: request.headers) { result in
            switch result {
            case let .success(result, _, _):
                self.handle(successs: result,
                            request: request,
                            completion: completion)
            case let .failure(error):
                completion(Result.error(error))
            }
        }
    }
    
    private func handle<T: CustomUploadRequest>(successs: UploadRequest,
                                                request: T,
                                                completion: @escaping (Result<T.ReturnType>) -> Void) {
        successs.responseJSON(completionHandler: { response in
            guard let data = response.data else {
                completion(Result.error(ServiceError.unknown))
                return
            }
            self.handle(success: data, request: request, completion: completion)
        })
    }
    
    private func handle<T: CustomUploadRequest>(success: Any,
                                                request: T,
                                                completion: @escaping ((Result<T.ReturnType>) -> Void)) {
        guard let data = success as? Data else {
            completion(Result.error(ServiceError.unknown))
            return
        }
        do {
            completion(Result.success(try request.mapper(data)))
        } catch {
            completion(Result.error(ServiceError.unknown))
        }
    }
}
