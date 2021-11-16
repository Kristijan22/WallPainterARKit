import ARKit

extension MainController: ARCoachingOverlayViewDelegate {

    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()

        coachingOverlay.delegate = self
        coachingOverlay.session = sceneView.session
        coachingOverlay.goal = .verticalPlane

        view.addSubview(coachingOverlay)
        coachingOverlay.fillToSuperview()
    }

}
