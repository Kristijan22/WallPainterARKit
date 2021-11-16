import ARKit
import Combine
import SceneKit

final class AnchorTracker {
    private var sceneView: ARSCNView?
    private var wallEntries: [ARPlaneAnchor: WallNode] = [:]
    private var meshEntries: [ARMeshAnchor: OcclusionNode] = [:]
    private var state: State = .blankWalls
    private var meshVisible: Bool = false

    enum State: Equatable {
        case blankWalls
        case choosingColor(wall: WallNode)

        var selectedWall: WallNode? {
            guard case let .choosingColor(wall) = self else { return nil }
            return wall
        }

    }
    
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
    }

    func selectWall(_ anchor: ARPlaneAnchor, completion: (Bool) -> Void) {
        guard let wallNode = wallEntries[anchor] else {
            completion(false)
            return
        }
        state = .choosingColor(wall: wallNode)
        completion(true)
    }

    func setColorOnSelectedWall(_ color: UIColor) {
        guard
            let wallNode = state.selectedWall
        else { return }

        wallNode.setColor(color)
    }
    
    func node(for meshAnchor: ARMeshAnchor) -> SCNNode? {
        let occlusionNode = OcclusionNode(meshAnchor: meshAnchor)
        meshEntries[meshAnchor] = occlusionNode
        return occlusionNode
    }

    func node(for wallAnchor: ARPlaneAnchor) -> SCNNode? {
        let wallNode = WallNode(planeAnchor: wallAnchor, sceneView: sceneView!)
        wallEntries[wallAnchor] = wallNode
        return wallNode
    }

    func update(_ node: SCNNode, for meshAnchor: ARMeshAnchor) {
        guard let occlusionNode = node as? OcclusionNode else { return }
        occlusionNode.updateOcclusionNode(with: meshAnchor, visible: meshVisible)
    }

    func update(_ node: SCNNode, for planeAnchor: ARPlaneAnchor) {
        guard let wallNode = node as? WallNode else { return }
        wallNode.updatePaintNode(on: planeAnchor)
    }

    func remove(_ node: SCNNode, on meshAnchor: ARMeshAnchor) {
        guard
            let occlusionNode = node as? OcclusionNode,
            let _ = meshEntries[meshAnchor]
        else { return }

        occlusionNode.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }

        meshEntries[meshAnchor] = nil
    }

    func remove(_ node: SCNNode, on planeAnchor: ARPlaneAnchor) {
        guard
            let wallNode = node as? WallNode,
            let _ = wallEntries[planeAnchor]
        else { return }

        wallNode.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }

        wallEntries[planeAnchor] = nil
    }

    func setMeshVisible(_ visible: Bool) {
        meshVisible = visible
    }

    func reset() {
        wallEntries.removeAll()
        meshEntries.removeAll()
        state = .blankWalls
    }
    
}
