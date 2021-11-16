import Combine
import UIKit

protocol MainViewRouterProtocol: AnyObject {

    func showSettingsList()

    func showColorPicker() -> AnyPublisher<UIColor, Never>
    
}

final class MainViewRouter: NSObject, MainViewRouterProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showSettingsList() {
        let settingsListData = SettingsRepositoryData.shared
        let settingsListRepository = SettingsRepository(settingsRepositoryData: settingsListData)
        let settingsListUseCase = SettingsListUseCase(settingsRepository: settingsListRepository)
        let settingsListPresenter = SettingsListPresenter(settingsListUseCase: settingsListUseCase)
        let settingsListViewController = SettingsListController(presenter: settingsListPresenter)

        navigationController.showDetailViewController(settingsListViewController, sender: self)
    }

    func showColorPicker() -> AnyPublisher<UIColor, Never> {
        let colorPicker = ColorPickerController()
        navigationController.showDetailViewController(colorPicker, sender: self)
        return colorPicker.colorSelected
    }
}
