import UIKit

struct SettingViewModel: Hashable {

    let settingModel: SettingModel
    let isOn: Bool

    init(from settingStateModel: SettingStateModel) {
        self.settingModel = settingStateModel.setting
        self.isOn = settingStateModel.isOn
    }

}
