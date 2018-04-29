import Swinject
import SwinjectStoryboard

final class AssemblyCenter {
    
    static let shared = AssemblyCenter()
    
    private(set) lazy var container: Assembler = {
        return Assembler(self.assemblies)
    }()
    
    private var assemblies: [Assembly] {
        return [
            AppDelegateAssembly(),
            EmotionRecognizerAssembly(),
            ServiceAssembly()
        ]
    }
}

extension AssemblyCenter {
    enum Keys: String {
        case remoteBaseName
        case apiKey
        case apiSecret
    }
}
