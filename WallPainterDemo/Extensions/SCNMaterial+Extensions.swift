import SceneKit

extension SCNMaterial {

    static var occluder: SCNMaterial {
        let material = SCNMaterial()
        material.colorBufferWriteMask = []
        return material
    }

    static func colored(with color: UIColor) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = color
        return material
    }

    static var visibleMesh: SCNMaterial {
        let material = SCNMaterial()
        material.fillMode = .lines
        material.diffuse.contents = UIColor.red
        return material
    }

}
