import Swinject

final class AppDelegateAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UIWindow.self) { _ in
            return UIWindow(frame: UIScreen.main.bounds)
        }
    }
}
