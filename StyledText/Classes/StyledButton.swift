import UIKit

open class StyledButton: UIButton {
    // swiftlint:disable opening_brace
    public var normalTextStyle: TextStyle = .unspecified    { didSet { updateStyles() }}
    public var highlightedTextStyle: TextStyle?             { didSet { updateStyles() }}
    public var disabledTextStyle: TextStyle?                { didSet { updateStyles() }}
    public var selectedTextStyle: TextStyle?                { didSet { updateStyles() }}

    open var hideTitle = false                              { didSet { updateStyles() }}

    private var normalTitle: String?                        { didSet { updateStyles() }}
    private var highlightedTitle: String?                   { didSet { updateStyles() }}
    private var disabledTitle: String?                      { didSet { updateStyles() }}
    private var selectedTitle: String?                      { didSet { updateStyles() }}
    // swiftlint:enable opening_brace

    private func updateStyles() {
        let normalTitle = self.normalTitle ?? ""

        func doUpdate(withText text: String, style: TextStyle, for state: UIControlState) {
            let styledText = StyledString(string: text, style: style)
            super.setAttributedTitle(hideTitle ? nil : styledText.styledAttributedStringValue, for: state)
        }

        doUpdate(withText: normalTitle,
                 style: normalTextStyle,
                 for: .normal)
        doUpdate(withText: highlightedTitle ?? normalTitle,
                 style: highlightedTextStyle ?? normalTextStyle,
                 for: .highlighted)
        doUpdate(withText: disabledTitle ?? normalTitle,
                 style: disabledTextStyle ?? normalTextStyle,
                 for: .disabled)
        doUpdate(withText: selectedTitle ?? normalTitle,
                 style: selectedTextStyle ?? normalTextStyle,
                 for: .selected)
    }

    // MARK: - Overrides

    override open func title(for state: UIControlState) -> String? {
        if state.contains(.normal) {
            return normalTitle
        } else if state.contains(.highlighted) {
            return highlightedTitle
        } else if state.contains(.disabled) {
            return disabledTitle
        } else if state.contains(.selected) {
            return selectedTitle
        } else {
            assertionFailure("invalid state")
            return nil
        }
    }

    override open func setTitle(_ title: String?, for state: UIControlState) {
        if state.contains(.normal) {
            normalTitle = title
        } else if state.contains(.highlighted) {
            highlightedTitle = title
        } else if state.contains(.disabled) {
            disabledTitle = title
        } else if state.contains(.selected) {
            selectedTitle = title
        } else {
            assertionFailure("invalid state")
        }
    }

    override open func titleColor(for state: UIControlState) -> UIColor? {
        assertionFailure("StyledButton must use TextStyle for title color")
        return nil
    }

    override open func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        assertionFailure("StyledButton must use TextStyle for title color")
    }
}
