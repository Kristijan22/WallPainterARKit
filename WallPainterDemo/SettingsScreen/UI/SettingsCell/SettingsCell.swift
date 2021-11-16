import Combine
import Foundation
import UIKit

final class SettingsCell: UITableViewCell {

    static let reuseIdentifier = String(describing: SettingsCell.self)

    var settingLabel: UILabel!
    var settingImage: UIImageView!
    var settingSwitch: UISwitch!

    var disposables = Set<AnyCancellable>()

    private var settingSwitchChangedSubject = PassthroughSubject<Bool, Never>()
    var settingSwitchChanged: AnyPublisher<Bool, Never> {
        settingSwitchChangedSubject.eraseToAnyPublisher()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        bindSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposables = Set<AnyCancellable>()
        settingLabel.text = nil
        settingImage.image = nil
    }

    func bindSwitch() {
        settingSwitch.addAction(.init { [weak self] _ in
            guard let self = self else { return }
            self.settingSwitchChangedSubject.send(self.settingSwitch.isOn)
        }, for: .valueChanged)
    }

    func set(viewModel: SettingViewModel) {
        settingLabel.text = viewModel.settingModel.name
        settingImage.image = UIImage(systemName: viewModel.settingModel.image) ?? UIImage(systemName: "gearshape.fill")!
        settingSwitch.setOn(viewModel.isOn, animated: false)
    }

}
