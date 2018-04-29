import Foundation

protocol ServiceProtocol {
    func upload<T: CustomUploadRequest>(request: T,
                                        completion: @escaping ((Result<T.ReturnType>) -> Void))
}
