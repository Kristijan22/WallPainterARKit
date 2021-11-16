import Combine
@testable import WallPainterDemo

class SettingsListUseCaseProtocolMock: SettingsListUseCaseProtocol {

    // MARK: - toggleState
    var toggleStateCallsCount = 0
    var toggleStateReceivedInvocations: [SettingModel] = []
    func toggleState(for setting: SettingModel) {
        toggleStateCallsCount += 1
        toggleStateReceivedInvocations.append(setting)
    }


    // MARK: - queryAllSettings
    var queryAllSettingsCallsCount = 0
    var queryAllSettingsReturnValue: AnyPublisher<[SettingStateModel], Never> = Empty(completeImmediately: true).eraseToAnyPublisher()
    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never> {
        queryAllSettingsCallsCount += 1
        return queryAllSettingsReturnValue
    }
}
