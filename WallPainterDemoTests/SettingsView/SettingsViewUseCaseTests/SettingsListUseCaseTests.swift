import XCTest
import Combine
@testable import WallPainterDemo

class SettingsListUseCaseTests: XCTestCase {

    // Mocked
    private var settingsRepository: SettingsRepositoryProtocolMock!

    // SUT
    private var settingsListUseCase: SettingsListUseCase!

    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        settingsRepository = SettingsRepositoryProtocolMock()
        settingsListUseCase = SettingsListUseCase(settingsRepository: settingsRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_toggleStateCallCount() {
        // Act
        settingsListUseCase.toggleState(for: .mesh)

        // Assert
        XCTAssertEqual(settingsRepository.toggleStateCallsCount, 1)
    }

    func test_toggleStateInvocation() {
        // Act
        settingsListUseCase.toggleState(for: .mesh)

        // Assert
        XCTAssertEqual(settingsRepository.toggleStateReceivedInvocations, [.mesh])
    }

    func test_queryAllSettingsCallCount() {
        // Act
        _ = settingsListUseCase.queryAllSettings()

        // Assert
        XCTAssertEqual(settingsRepository.queryAllSettingsCallsCount, 1)
    }

    func test_settingsViewModels() throws {
        //Arrange
        let settings: [SettingStateModel] = [.init(setting: .mesh, isOn: true)]
        settingsRepository.queryAllSettingsReturnValue = Just(settings).eraseToAnyPublisher()

        // Act
        settingsListUseCase
            .queryAllSettings()
            .sink(receiveValue: { settingsStateModels in
                // Assert
                XCTAssertEqual(settingsStateModels, settings)
            })
            .store(in: &disposables)
    }


}
