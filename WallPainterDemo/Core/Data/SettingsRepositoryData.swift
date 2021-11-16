import Combine

final class SettingsRepositoryData: SettingsRepositoryDataProtocol {

    // This could be saved to user defaults instead, but I'll keep it simple for now. Later it can be substituted with other data source
    static let shared = SettingsRepositoryData()

    private init() {}

    @Published var settingStateModels: [SettingStateModel] = [
        SettingStateModel(setting: .mesh, isOn: false),
        SettingStateModel(setting: .peopleOcclusion, isOn: true)
    ]

    var settingStateModelsPublisher: Published<[SettingStateModel]>.Publisher { $settingStateModels }
}
