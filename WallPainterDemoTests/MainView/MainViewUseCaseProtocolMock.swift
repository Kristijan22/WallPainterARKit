import Combine
@testable import WallPainterDemo

class MainViewUseCaseProtocolMock: MainViewUseCaseProtocol {

    // MARK: - queryAllSettings
    var queryAllSettingsCallCount = 0
    var queryAllSettingsReturnValue: AnyPublisher<[SettingStateModel], Never> = Empty(completeImmediately: true).eraseToAnyPublisher()
    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never> {
        queryAllSettingsCallCount += 1
        return queryAllSettingsReturnValue
    }

}
