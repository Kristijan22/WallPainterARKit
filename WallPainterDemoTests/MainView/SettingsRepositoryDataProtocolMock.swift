import Combine
@testable import WallPainterDemo

class SettingsRepositoryDataProtocolMock: SettingsRepositoryDataProtocol {

    var settingStateModelsPublisher: Published<[SettingStateModel]>.Publisher { $settingStateModels }

    @Published var settingStateModels: [SettingStateModel] = [
        .init(setting: .mesh, isOn: false),
        .init(setting: .peopleOcclusion, isOn: false)
    ]

}
