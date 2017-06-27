import Foundation

internal extension UIFont {
    internal func byScalingToDynamicTypeFontSize() -> UIFont {
        let contentSize = UIApplication.shared.preferredContentSizeCategory
        let scaleFactor: CGFloat
        switch contentSize {
        case UIContentSizeCategory.extraSmall:
            scaleFactor = 0.8
        case UIContentSizeCategory.small:
            scaleFactor = 0.9
        case UIContentSizeCategory.medium:
            scaleFactor = 1.0
        case UIContentSizeCategory.large:
            scaleFactor = 1.1
        case UIContentSizeCategory.extraLarge:
            scaleFactor = 1.2
        case UIContentSizeCategory.extraExtraLarge:
            scaleFactor = 1.3
        case UIContentSizeCategory.extraExtraExtraLarge,
             UIContentSizeCategory.accessibilityMedium,
             UIContentSizeCategory.accessibilityLarge,
             UIContentSizeCategory.accessibilityExtraLarge,
             UIContentSizeCategory.accessibilityExtraExtraLarge,
             UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            scaleFactor = 1.4
        default:
            return self
        }
        return self.withSize(self.pointSize * scaleFactor)
    }
}
