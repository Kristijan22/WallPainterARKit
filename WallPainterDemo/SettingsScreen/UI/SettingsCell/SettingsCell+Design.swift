import UIKit

extension SettingsCell {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        settingLabel = UILabel()
        contentView.addSubview(settingLabel)

        settingImage = UIImageView()
        contentView.addSubview(settingImage)

        settingSwitch = UISwitch()
        contentView.addSubview(settingSwitch)
    }

    private func styleViews() {}

    private func defineLayoutForViews() {
        settingImage.anchorCenterYToSuperview()
        settingImage.anchor(left: contentView.leftAnchor, leftConstant: 12, widthConstant: 24)

        settingLabel.anchorCenterYToSuperview()
        settingLabel.anchor(left: settingImage.rightAnchor, leftConstant: 8)

        settingSwitch.anchorCenterYToSuperview()
        settingSwitch.anchor(right: contentView.rightAnchor, rightConstant: 12)
    }

}
