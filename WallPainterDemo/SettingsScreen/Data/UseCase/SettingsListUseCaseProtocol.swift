import Combine

protocol SettingsListUseCaseProtocol {

    func toggleState(for setting: SettingModel)

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never>

}
