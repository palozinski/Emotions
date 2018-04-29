import Swinject
import SwinjectAutoregistration

final class ServiceAssembly: Assembly {
    
    typealias Keys = AssemblyCenter.Keys
    
    func assemble(container: Container) {
        
        container.register(String.self, name: Keys.remoteBaseName.rawValue) { _ in
            return InfoConfig(bundle: .main).value(for: .endpointBase) as String
        }
        
        container.register(String.self, name: Keys.apiKey.rawValue) { _ in
            return InfoConfig(bundle: .main).value(for: .faceppApiKey) as String
        }
        
        container.register(String.self, name: Keys.apiSecret.rawValue) { _ in
            return InfoConfig(bundle: .main).value(for: .faceppApiSecret) as String
        }
        
        container.register(EmotionsRecognitionService.self) { resolver in
            return EmotionsRecognitionService(apiKey: resolver.resolve(String.self, name: Keys.apiKey.rawValue)!,
                                              apiSecret: resolver.resolve(String.self, name: Keys.apiSecret.rawValue)!,
                                              service: resolver.resolve(ServiceProtocol.self)!)
        }
        
        container.register(ServiceProtocol.self) { resolver in
            let base = resolver.resolve(String.self, name: Keys.remoteBaseName.rawValue)
            return ApiService(base: base!)
        }
    }
}
