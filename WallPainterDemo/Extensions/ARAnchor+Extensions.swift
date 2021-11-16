import ARKit

extension ARAnchor {

    var asMeshAnchor: ARMeshAnchor? {
        guard let meshAnchor = self as? ARMeshAnchor else { return nil }
        return meshAnchor
    }

    var asWallAnchor: ARPlaneAnchor? {
        guard let planeAnchor = self as? ARPlaneAnchor else { return nil }

        if ARPlaneAnchor.isClassificationSupported {
            return planeAnchor.classification == .wall ? planeAnchor : nil
        } else {
            return planeAnchor
        }
    }

}

extension Array where Element == ARAnchor {

    var mapWallAnchors: [ARPlaneAnchor] {
        self.compactMap { $0.asWallAnchor }
    }

}
