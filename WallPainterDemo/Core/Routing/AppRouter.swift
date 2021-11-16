import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setStartScreen(in window: UIWindow) {
        let mainViewRouter = MainViewRouter(navigationController: navigationController)
        let settingsRepositoryData = SettingsRepositoryData.shared
        let mainViewUseCase = MainViewUseCase(settingsRepositoryData: settingsRepositoryData)
        let mainViewPresenter = MainViewPresenter(mainViewRouter: mainViewRouter, mainViewUseCase: mainViewUseCase)
        let vc = MainController(presenter: mainViewPresenter)

        navigationController.pushViewController(vc, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
