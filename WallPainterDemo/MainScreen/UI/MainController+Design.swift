import ARKit
import UIKit

extension MainController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        sceneView = ARSCNView()
        view.addSubview(sceneView)

        settingsButton = UIButton()
        view.addSubview(settingsButton)

        snapshotButton = UIButton()
        view.addSubview(snapshotButton)

        resetButton = UIButton()
        view.addSubview(resetButton)

        addCoaching()
    }

    private func styleViews() {
        let settingsImage = UIImage(
            systemName: "switch.2",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 48))
        )?.withRenderingMode(.alwaysOriginal)
        settingsButton.setImage(settingsImage, for: .normal)

        let cameraImage = UIImage(
            systemName: "camera.circle",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 64))
        )?.withRenderingMode(.alwaysOriginal)
        snapshotButton.setImage(cameraImage, for: .normal)

        resetButton.setTitle("RESET", for: .normal)
        resetButton.backgroundColor = .red
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 6
    }

    private func defineLayoutForViews() {
        sceneView.fillToSuperview()

        settingsButton.anchor(
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            bottomConstant: 32,
            rightConstant: 16)

        snapshotButton.anchorCenterXToSuperview()
        snapshotButton.anchor(bottom: view.bottomAnchor, bottomConstant: 24)

        resetButton.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            leftConstant: 16,
            bottomConstant: 32,
            heightConstant: 32)
        resetButton.setInsets(forContentPadding: .init(top: 0, left: 6, bottom: 0, right: 6), imageTitlePadding: 0)
    }

}
