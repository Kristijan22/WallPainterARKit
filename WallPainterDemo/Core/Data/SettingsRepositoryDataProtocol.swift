import Combine

protocol SettingsRepositoryDataProtocol: AnyObject {

    var settingStateModelsPublisher: Published<[SettingStateModel]>.Publisher { get }

}
