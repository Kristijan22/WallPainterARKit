import Combine

class SettingsRepository: SettingsRepositoryProtocol {

    private var settingsRepositoryData: SettingsRepositoryData

    init(settingsRepositoryData: SettingsRepositoryData) {
        self.settingsRepositoryData = settingsRepositoryData
    }

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never> {
        settingsRepositoryData
            .$settingStateModels
            .eraseToAnyPublisher()
    }

    func toggleState(for setting: SettingModel) {
        var currentSettingsStateModels = settingsRepositoryData.settingStateModels
        guard let index = currentSettingsStateModels.firstIndex(where: { $0.setting == setting })
        else {
            assertionFailure("Setting not found.")
            return
        }
        let currentState = currentSettingsStateModels[index]
        let newState = SettingStateModel(setting: currentState.setting, isOn: !currentState.isOn)

        currentSettingsStateModels[index] = newState
        settingsRepositoryData.settingStateModels = currentSettingsStateModels
    }

}
