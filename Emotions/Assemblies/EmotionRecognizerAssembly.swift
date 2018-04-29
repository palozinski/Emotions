import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

final class EmotionRecognizerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.autoregister(EmotionsRecognizerContainerViewModel.self, initializer: EmotionsRecognizerContainerViewModel.init)
        container.storyboardInitCompleted(RecognizerContainerViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(EmotionsRecognizerContainerViewModel.self)
        }
        
        container.autoregister(ResultListSataSource.self, initializer: ResultListSataSource.init)
        container.storyboardInitCompleted(ResultListViewController.self) { resolver, controller in
            controller.dataSource = resolver.resolve(ResultListSataSource.self)
        }
    }
}
