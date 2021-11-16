import Combine
import Foundation

final class SettingsListPresenter {

    private let settingsListUseCase: SettingsListUseCaseProtocol

    private var disposables = Set<AnyCancellable>()

    init(settingsListUseCase: SettingsListUseCaseProtocol) {
        self.settingsListUseCase = settingsListUseCase
        bindUseCase()
    }

    private var settingsViewModelsSubject = CurrentValueSubject<[SettingViewModel], Never>([])
    var settingsViewModels: AnyPublisher<[SettingViewModel], Never> {
        settingsViewModelsSubject
            .eraseToAnyPublisher()
    }

    func toggle(_ setting: SettingModel) {
        settingsListUseCase.toggleState(for: setting)
    }

    private func bindUseCase() {
        settingsListUseCase
            .queryAllSettings()
            .sink(receiveValue: { [weak self] settingsStateModels in
                let viewModels = settingsStateModels.map { SettingViewModel(from: $0) }
                self?.settingsViewModelsSubject.send(viewModels)
            })
            .store(in: &disposables)
    }

}
