import XCTest
import Combine
@testable import WallPainterDemo

class MainViewUseCaseTests: XCTestCase {

    // Mocked
    private var settingsRepositoryData: SettingsRepositoryDataProtocolMock!

    // SUT
    private var mainViewUseCase: MainViewUseCaseProtocol!

    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        settingsRepositoryData = SettingsRepositoryDataProtocolMock()
        mainViewUseCase = MainViewUseCase(settingsRepositoryData: settingsRepositoryData)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testQueryAllSettings_With_No_Settings() {
        // Arrange
        settingsRepositoryData.settingStateModels = []

        // Act
        mainViewUseCase
            .queryAllSettings()
            .sink(receiveValue: { settings in
                // Assert
                XCTAssertEqual(settings.count, 0)
            })
            .store(in: &disposables)
    }

    func testQueryAllSettings_With_One_Setting() {
        // Arrange
        let setting = SettingStateModel(setting: .peopleOcclusion, isOn: false)
        settingsRepositoryData.settingStateModels = [setting]

        // Act
        mainViewUseCase
            .queryAllSettings()
            .sink(receiveValue: { settings in
                // Assert
                XCTAssertEqual(settings.count, 1)
                XCTAssertEqual(settings.first, setting)
            })
            .store(in: &disposables)
    }

}
