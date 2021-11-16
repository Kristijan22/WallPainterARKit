import XCTest
import Combine
@testable import WallPainterDemo

class MainViewPresenterTests: XCTestCase {

    // Mocked
    private var mainViewUseCase: MainViewUseCaseProtocolMock!
    private var mainViewRouter: MainViewRouterProtocolMock!

    // SUT
    private var mainViewPresenter: MainViewPresenter!

    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        mainViewRouter = MainViewRouterProtocolMock()
        mainViewUseCase = MainViewUseCaseProtocolMock()
        mainViewPresenter = MainViewPresenter(mainViewRouter: mainViewRouter, mainViewUseCase: mainViewUseCase)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_showColorPickerCallCount() {
        // Act
        mainViewPresenter.showColorPicker()

        // Assert
        XCTAssertEqual(mainViewRouter.showColorPickerCallCount, 1)
    }

    func test_selectColorInColorPicker() {
        // Arrange
        let color = UIColor.white
        mainViewRouter.showColorPickerReturnValue = Just(color).eraseToAnyPublisher()

        mainViewPresenter
            .colorSelected
            .sink(receiveValue: { selectedColor in
                // Assert
                XCTAssertEqual(selectedColor, color)
            })
            .store(in: &disposables)

        // Act
        mainViewPresenter.showColorPicker()
    }

    func test_showSettingsCallCount() {
        // Act
        mainViewPresenter.showSettings()

        // Assert
        XCTAssertEqual(mainViewRouter.showSettingsListCallCount, 1)
    }

    func test_settingsState() {
        // Arrange
        let settings: [SettingStateModel] = [.init(setting: .mesh, isOn: false), .init(setting: .peopleOcclusion, isOn: true)]
        mainViewUseCase.queryAllSettingsReturnValue = Just(settings).eraseToAnyPublisher()
        mainViewPresenter = MainViewPresenter(mainViewRouter: mainViewRouter, mainViewUseCase: mainViewUseCase)

        // Act
        mainViewPresenter
            .settingsState
            .sink(receiveValue: { settingsState in
                // Assert
                XCTAssertEqual(settingsState, settings)
            })
            .store(in: &disposables)
    }

}
