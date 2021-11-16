import ARKit
import Combine
import UIKit

final class MainController: UIViewController {

    var sceneView: ARSCNView!
    var settingsButton: UIButton!
    var resetButton: UIButton!
    var snapshotButton: UIButton!
    var anchorTracker: AnchorTracker?

    let presenter: MainViewPresenter
    private var disposables = Set<AnyCancellable>()
    private var configuration: ARWorldTrackingConfiguration!

    init(presenter: MainViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        configureWorldTracking()
        setupGestureRecognizers()
        bindPresenter()
        addSnapshotAction()
        addSettingsAction()
        addResetAction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        startSession()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        sceneView.session.pause()
    }

    private func configureWorldTracking() {
        let oldFrameSemantics = configuration?.frameSemantics
        configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical

        let sceneReconstruction: ARWorldTrackingConfiguration.SceneReconstruction = .meshWithClassification
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(sceneReconstruction) {
            configuration.sceneReconstruction = sceneReconstruction
        }

        if let frameSemantics = oldFrameSemantics {
            configuration.frameSemantics = frameSemantics
        }
        sceneView.delegate = self
    }

    private func startSession(reset: Bool = false) {
        var options: ARSession.RunOptions = []
        if reset {
            options = [.removeExistingAnchors, .resetTracking, .resetSceneReconstruction]
        }

        sceneView.session.run(configuration, options: options)

        if anchorTracker == nil {
            anchorTracker = AnchorTracker(sceneView: sceneView)
        } else if reset {
            anchorTracker?.reset()
        }
    }

    private func bindPresenter() {
        presenter
            .colorSelected
            .sink(receiveValue: { [weak self] colorSelected in
                self?.anchorTracker?.setColorOnSelectedWall(colorSelected)
            })
            .store(in: &disposables)

        presenter
            .settingsState
            .sink(receiveValue: { [weak self] settings in
                guard let self = self else { return }
                settings.forEach { settingModel in
                    switch settingModel.setting {
                    case .peopleOcclusion:
                        if settingModel.isOn {
                            self.configuration.frameSemantics.insert(.personSegmentationWithDepth)
                        } else {
                            self.configuration.frameSemantics.remove(.personSegmentationWithDepth)
                        }
                        self.startSession()
                    case .mesh:
                        self.anchorTracker?.setMeshVisible(settingModel.isOn)
                    }
                }
            })
            .store(in: &disposables)
    }

    private func addSnapshotAction() {
        snapshotButton.addAction(.init { [weak self] _ in
            guard
                let image = self?.sceneView.snapshot(),
                let pngData = image.pngData(),
                let compressedImage = UIImage(data: pngData)
            else { return }

            self?.view.showScreenshotEffect()
            UIImageWriteToSavedPhotosAlbum(compressedImage, nil, nil, nil)
        }, for: .touchUpInside)
    }

    private func addSettingsAction() {
        settingsButton.addAction(.init { [weak self] _ in
            self?.presenter.showSettings()
        }, for: .touchUpInside)
    }

    private func addResetAction() {
        resetButton.addAction(.init { [weak self] _ in
            self?.resetSession()
        }, for: .touchUpInside)
    }

    private func resetSession() {
        configureWorldTracking()
        startSession(reset: true)
    }

}
