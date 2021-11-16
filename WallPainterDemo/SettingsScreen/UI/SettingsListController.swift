import Combine
import UIKit

enum Section {

    case main

}

final class SettingsListController: UIViewController {

    var tableView: UITableView!
    private let presenter: SettingsListPresenter

    private typealias DataSource = UITableViewDiffableDataSource<Section, SettingViewModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, SettingViewModel>

    private var dataSource: DataSource!
    private var disposables = Set<AnyCancellable>()

    init(presenter: SettingsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        buildTableView()
        bindPresenter()
    }

    private func buildTableView() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.rowHeight = 66

        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item -> UITableViewCell? in
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: SettingsCell.reuseIdentifier,
                        for: indexPath) as? SettingsCell
                else { return nil }

                cell.set(viewModel: item)
                cell.settingSwitchChanged
                    .sink(receiveValue: { [weak self] value in
                        self?.presenter.toggle(item.settingModel)
                    }).store(in: &cell.disposables)

                return cell
            })
    }

    private func bindPresenter() {
        presenter.settingsViewModels
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] viewModels in
                self?.updateSnapshot(items: viewModels)
            })
            .store(in: &disposables)
    }

    private func updateSnapshot(items: [SettingViewModel]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}
