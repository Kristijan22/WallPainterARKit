import ARKit

// MARK: ARSCNViewDelegate
extension MainController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if let meshAnchor = anchor.asMeshAnchor {
            return anchorTracker?.node(for: meshAnchor)
        }

        if let wallAnchor = anchor.asWallAnchor {
            return anchorTracker?.node(for: wallAnchor)
        }

        return nil
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let meshAnchor = anchor.asMeshAnchor {
            anchorTracker?.update(node, for: meshAnchor)
        }

        if let wallAnchor = anchor.asWallAnchor {
            anchorTracker?.update(node, for: wallAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let meshAnchor = anchor.asMeshAnchor {
            anchorTracker?.remove(node, on: meshAnchor)
        }

        if let wallAnchor = anchor.asWallAnchor {
            anchorTracker?.remove(node, on: wallAnchor)
        }
    }

}
