import Combine

class SettingsListUseCase: SettingsListUseCaseProtocol {

    private let settingsRepository: SettingsRepositoryProtocol

    init(settingsRepository: SettingsRepositoryProtocol) {
        self.settingsRepository = settingsRepository
    }

    func toggleState(for setting: SettingModel) {
        settingsRepository.toggleState(for: setting)
    }

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never> {
        settingsRepository.queryAllSettings()
    }

}
