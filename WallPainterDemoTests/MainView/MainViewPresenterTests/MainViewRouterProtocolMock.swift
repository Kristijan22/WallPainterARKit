import Combine
import UIKit
@testable import WallPainterDemo

class MainViewRouterProtocolMock: MainViewRouterProtocol {

    // MARK: - showSettingsList
    var showSettingsListCallCount = 0
    func showSettingsList() {
        showSettingsListCallCount += 1
    }

    // MARK: - showColorPicker
    var showColorPickerCallCount = 0
    var showColorPickerReturnValue: AnyPublisher<UIColor, Never> = Empty(completeImmediately: true).eraseToAnyPublisher()
    func showColorPicker() -> AnyPublisher<UIColor, Never> {
        showColorPickerCallCount += 1
        return showColorPickerReturnValue
    }

}
