import Foundation
import UIKit
import ARKit

// MARK: Gesture Handling
extension MainController {

    func setupGestureRecognizers() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: sceneView)
        guard let query = sceneView.raycastQuery(from: tapLocation, allowing: .existingPlaneInfinite, alignment: .vertical) else { return }
        let planeIntersection = sceneView.session.raycast(query)
        guard let wallAnchor = planeIntersection.compactMap({ $0.anchor?.asWallAnchor }).first else { return }

        anchorTracker?.selectWall(wallAnchor) { success in
            if success {
                presenter.showColorPicker()
            }
        }

    }

}
