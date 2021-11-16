import Combine
import UIKit

class ColorPickerController: UIColorPickerViewController {

    private var colorSelectedSubject = PassthroughSubject<UIColor, Never>()
    var colorSelected: AnyPublisher<UIColor, Never> {
        colorSelectedSubject.eraseToAnyPublisher()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        supportsAlpha = true
    }

}

extension ColorPickerController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorSelectedSubject.send(viewController.selectedColor)
    }

}
