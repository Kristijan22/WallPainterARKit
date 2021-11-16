import Combine

final class MainViewUseCase: MainViewUseCaseProtocol {

    private let settingsRepositoryData: SettingsRepositoryDataProtocol

    init(settingsRepositoryData: SettingsRepositoryDataProtocol) {
        self.settingsRepositoryData = settingsRepositoryData
    }

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never> {
        settingsRepositoryData
            .settingStateModelsPublisher
            .eraseToAnyPublisher()
    }

}
