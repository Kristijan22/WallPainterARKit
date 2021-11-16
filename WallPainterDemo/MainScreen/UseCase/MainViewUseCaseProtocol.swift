import Combine

protocol MainViewUseCaseProtocol: AnyObject {

    func queryAllSettings() -> AnyPublisher<[SettingStateModel], Never>

}
