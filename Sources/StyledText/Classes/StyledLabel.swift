#if canImport(UIKit)

import UIKit

public class StyledLabel: UILabel {
    public var textStyle: TextStyle {
        get { return styledText.style }
        set { styledText.style = newValue }
    }

    public var styledText: StyledText = StyledString(string: "", style: .unspecified) {
        didSet {
            refreshStyle()
        }
    }

    override public var text: String? {
        get {
            return super.attributedText?.string
        }
        set {
            guard let text = newValue else {
                super.attributedText = nil
                return
            }

            styledText = StyledString(string: text, style: textStyle)
        }
    }

    override public var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }
        set {
            guard let text = newValue else {
                super.attributedText = nil
                return
            }

            styledText = StyledAttributedString(attributedString: text, style: textStyle)
        }
    }

    public func refreshStyle() {
        super.attributedText = styledText.styledAttributedStringValue
    }
}

#endif
