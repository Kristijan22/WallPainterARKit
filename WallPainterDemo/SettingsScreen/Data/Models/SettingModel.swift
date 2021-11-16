enum SettingModel {

    case mesh
    case peopleOcclusion

    var name: String {
        switch self {
        case .mesh: return "Mesh"
        case .peopleOcclusion: return "People occlusion"
        }
    }

    var image: String {
        switch self {
        case .mesh: return "grid"
        case .peopleOcclusion: return "person.fill"
        }
    }

}
