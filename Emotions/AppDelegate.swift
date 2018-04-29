import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var resolver: Resolver {
        return AssemblyCenter
            .shared
            .container
            .resolver
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow(container: resolver)
        application.statusBarStyle = .lightContent
        return true
    }
    
    private func setupWindow(container: Resolver) {
        window = resolver.resolve(UIWindow.self)
        window?.makeKeyAndVisible()
        let storyboard = SwinjectStoryboard.create(name: "Rezognizer", bundle: nil, container: resolver)
        window?.rootViewController = storyboard.instantiateInitialViewController()
    }
}
