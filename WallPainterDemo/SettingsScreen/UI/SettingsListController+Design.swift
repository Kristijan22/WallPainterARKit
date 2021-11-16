import UIKit

extension SettingsListController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        tableView = UITableView()
        view.addSubview(tableView)
    }

    private func styleViews() {}

    private func defineLayoutForViews() {
        tableView.fillToSuperview()
    }

}
