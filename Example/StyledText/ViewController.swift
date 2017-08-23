import UIKit
import StyledText

class ViewController: UIViewController {
    private let topStyledLabel: StyledLabel = {
        let label = StyledLabel(frame: .zero)
        label.textStyle = TextStyle(font: .boldSystemFont(ofSize: 24.0),
                                    color: .orange,
                                    lineHeightMultiple: 1.5,
                                    kern: 1.0,
                                    alignment: .right)
        return label
    }()


    private let middleStyledLabel: StyledLabel = {
        let label = StyledLabel(frame: .zero)
        label.textStyle = TextStyle(font: .boldSystemFont(ofSize: 24.0),
                                    color: .red,
                                    lineHeightMultiple: 1.0,
                                    kern: 0.0,
                                    alignment: .center)
        return label
    }()


    private let bottomStyledLabel: StyledLabel = {
        let label = StyledLabel(frame: .zero)
        label.textStyle = TextStyle(font: .boldSystemFont(ofSize: 24.0),
                                    color: .purple,
                                    lineHeightMultiple: 0.5,
                                    kern: -1.0,
                                    alignment: .left)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.frame = view.bounds
        view.addSubview(stackView)

        [topStyledLabel, middleStyledLabel, bottomStyledLabel].forEach { label in
            stackView.addArrangedSubview(label)
            label.numberOfLines = 0
            label.text = "StyledLabel\nStyledLabel\nStyledLabel"
        }
    }
}

