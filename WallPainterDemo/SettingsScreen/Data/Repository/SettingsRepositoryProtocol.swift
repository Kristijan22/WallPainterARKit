import Combine

protocol SettingsRepositoryProtocol {

    func toggleState(for setting: SettingModel)

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never>

}
