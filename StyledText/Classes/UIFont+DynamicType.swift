import Foundation

internal extension UIFont {

    // We get these default scaling factors from comparing sizes of iOS Body text to the default
    internal func byScalingToDynamicTypeFontSize() -> UIFont {
        let contentSize = UIApplication.shared.preferredContentSizeCategory
        let scaleFactor: CGFloat
        switch contentSize {
        case UIContentSizeCategory.extraSmall:
            scaleFactor = 0.824
        case UIContentSizeCategory.small:
            scaleFactor = 0.882
        case UIContentSizeCategory.medium:
            scaleFactor = 0.941
        case UIContentSizeCategory.large:  // default category
            scaleFactor = 1.0
        case UIContentSizeCategory.extraLarge:
            scaleFactor = 1.118
        case UIContentSizeCategory.extraExtraLarge:
            scaleFactor = 1.235
        case UIContentSizeCategory.extraExtraExtraLarge:
            scaleFactor = 1.353
        case UIContentSizeCategory.accessibilityMedium:
            scaleFactor = 1.647
        case UIContentSizeCategory.accessibilityLarge:
            scaleFactor = 1.941
        case UIContentSizeCategory.accessibilityExtraLarge:
            scaleFactor = 2.353
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            scaleFactor = 2.765
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            scaleFactor = 3.118
        default:
            return self
        }
        let integralScaledSize = round(self.pointSize * scaleFactor)
        return self.withSize(integralScaledSize)
    }
}
