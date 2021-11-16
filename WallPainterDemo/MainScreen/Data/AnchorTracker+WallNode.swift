import ARKit
import SceneKit
import SceneKit.ModelIO

extension AnchorTracker {
    
    class WallNode: SCNNode {
        private var paintNode: SCNNode!
        private var paintBrushNode: SCNNode!
        private var color: UIColor = .clear
        private var sceneView: ARSCNView!

        private var isColored: Bool {
            color != .clear
        }

        init(planeAnchor: ARPlaneAnchor, sceneView: ARSCNView) {
            super.init()
            self.sceneView = sceneView

            createPaintBrushNode()
            createPaintNode(on: planeAnchor)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func getPaintNodeGeometry(for planeAnchor: ARPlaneAnchor) -> ARSCNPlaneGeometry {
            if let planeGeometry = paintNode?.geometry as? ARSCNPlaneGeometry {
                planeGeometry.update(from: planeAnchor.geometry)
                return planeGeometry
            } else {
                guard let planeGeometry = ARSCNPlaneGeometry(device: sceneView.device!)
                else {
                    fatalError("Can't create ARSCNPlaneGeometry.")
                }
                planeGeometry.update(from: planeAnchor.geometry)
                return planeGeometry
            }
        }

        func updatePaintNode(on planeAnchor: ARPlaneAnchor) {
            paintBrushNode.removeFromParentNode()
            paintNode.removeFromParentNode()
            createPaintNode(on: planeAnchor)
        }

        func setColor(_ color: UIColor) {
            self.color = color
        }

        private func createPaintNode(on planeAnchor: ARPlaneAnchor) {
            let material = SCNMaterial.colored(with: color)
            let planeGeometry = getPaintNodeGeometry(for: planeAnchor)
            planeGeometry.firstMaterial = material
            paintNode = SCNNode(geometry: planeGeometry)
            paintNode.renderingOrder = 0
            paintNode.simdPosition = [0, 0.01, 0] // Z-fighting issue

            addChildNode(paintNode)

            if !isColored {
                addChildNode(paintBrushNode)
                paintBrushNode.simdPosition = planeAnchor.center
                paintBrushNode.simdPosition.y = 0.1
            }
        }

        private func pulseAction() -> SCNAction {
            let scaleUpAction = SCNAction.scale(by: 1.2, duration: 1)
            let scaleDownAction = SCNAction.scale(by: 0.8, duration: 1)
            scaleUpAction.timingMode = .easeInEaseOut
            scaleDownAction.timingMode = .easeInEaseOut
            return SCNAction.repeatForever(SCNAction.sequence([scaleUpAction, scaleDownAction]))
        }

        private func createPaintBrushNode() {
            guard let urlPath = Bundle.main.url(forResource: "PaintRoller", withExtension: "usdz") else {
                return
            }
            let mdlAsset = MDLAsset(url: urlPath)
            mdlAsset.loadTextures()

            let asset = mdlAsset.object(at: 0)
            paintBrushNode = SCNNode(mdlObject: asset)
            paintBrushNode.eulerAngles.x = -.pi / 2
            paintBrushNode.simdScale = SIMD3<Float>(repeating: 0.2)
            paintBrushNode.runAction(pulseAction())
        }
    }

}
