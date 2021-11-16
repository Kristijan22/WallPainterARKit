import XCTest
import Combine
@testable import WallPainterDemo

class SettingsListPresenterTests: XCTestCase {

    // Mocked
    private var settingsListUseCase: SettingsListUseCaseProtocolMock!

    // SUT
    private var settingsListPresenter: SettingsListPresenter!

    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        settingsListUseCase = SettingsListUseCaseProtocolMock()
        settingsListPresenter = SettingsListPresenter(settingsListUseCase: settingsListUseCase)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_toggleStateCallCount() {
        // Act
        settingsListPresenter.toggle(.mesh)

        // Assert
        XCTAssertEqual(settingsListUseCase.toggleStateCallsCount, 1)
    }

    func test_toggleStateInvocation() {
        // Act
        settingsListPresenter.toggle(.mesh)

        // Assert
        XCTAssertEqual(settingsListUseCase.toggleStateReceivedInvocations, [.mesh])
    }

    func test_queryAllSettingsCallCount() {
        // Assert, call is made during init
        XCTAssertEqual(settingsListUseCase.queryAllSettingsCallsCount, 1)
    }

    func test_settingsViewModels() throws {
        //Arrange
        let settings: [SettingStateModel] = [.init(setting: .mesh, isOn: true)]
        let expectedViewModels: [SettingViewModel] = [.init(from: try XCTUnwrap(settings.first))]
        settingsListUseCase.queryAllSettingsReturnValue = Just(settings).eraseToAnyPublisher()
        settingsListPresenter = SettingsListPresenter(settingsListUseCase: settingsListUseCase)

        // Act
        settingsListPresenter
            .settingsViewModels
            .sink(receiveValue: { settingsViewModels in
                // Assert
                XCTAssertEqual(settingsViewModels, expectedViewModels)
            })
            .store(in: &disposables)
    }


}
