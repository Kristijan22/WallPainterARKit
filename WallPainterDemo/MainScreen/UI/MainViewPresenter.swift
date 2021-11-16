import Combine
import UIKit

final class MainViewPresenter {

    private let mainViewRouter: MainViewRouterProtocol
    private let mainViewUseCase: MainViewUseCaseProtocol

    private var disposables = Set<AnyCancellable>()
    private var colorSelectedSubject = PassthroughSubject<UIColor, Never>()
    var colorSelected: AnyPublisher<UIColor, Never> {
        colorSelectedSubject.eraseToAnyPublisher()
    }

    private var settingsStateSubject = CurrentValueSubject<[SettingStateModel], Never>([])
    var settingsState: AnyPublisher<[SettingStateModel], Never> {
        settingsStateSubject.eraseToAnyPublisher()
    }

    init(mainViewRouter: MainViewRouterProtocol, mainViewUseCase: MainViewUseCaseProtocol) {
        self.mainViewRouter = mainViewRouter
        self.mainViewUseCase = mainViewUseCase
        bindUseCase()
    }

    private func bindUseCase() {
        mainViewUseCase
            .queryAllSettings()
            .sink(receiveValue: { [weak self] settings in
                self?.settingsStateSubject.send(settings)
            })
            .store(in: &disposables)
    }

    func showColorPicker() {
        mainViewRouter
            .showColorPicker()
            .sink(receiveValue: { [weak self] selectedColor in
                self?.colorSelectedSubject.send(selectedColor)
            })
            .store(in: &disposables)
    }

    func showSettings() {
        mainViewRouter.showSettingsList()
    }

}
