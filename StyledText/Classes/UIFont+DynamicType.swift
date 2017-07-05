import Foundation

internal extension UIFont {
    // We get these default scaling factors from comparing sizes of iOS Body text to the default
    internal func byScalingToDynamicTypeFontSize(supportAccessibiltySizes: Bool = false) -> UIFont {
        var contentSize = UIApplication.shared.preferredContentSizeCategory
        if contentSize.isAccessibilityCategory && supportAccessibiltySizes == false {
            contentSize = .extraExtraExtraLarge
        }

        let scaleFactor: CGFloat
        switch contentSize {
        // Standard Sizes:
        case UIContentSizeCategory.extraSmall:
            scaleFactor = 0.824
        case UIContentSizeCategory.small:
            scaleFactor = 0.882
        case UIContentSizeCategory.medium:
            scaleFactor = 0.941
        case UIContentSizeCategory.extraLarge:
            scaleFactor = 1.118
        case UIContentSizeCategory.extraExtraLarge:
            scaleFactor = 1.235
        case UIContentSizeCategory.extraExtraExtraLarge:
            scaleFactor = 1.353
        // Accessibility Sizes:
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
        // Default Size:
        case UIContentSizeCategory.large:
            fallthrough
        default: // catches .unspecified
            scaleFactor = 1.0
        }
        let integralScaledSize = round(self.pointSize * scaleFactor)
        return self.withSize(integralScaledSize)
    }
}

private extension UIContentSizeCategory {
    // This will need to be modified for iOS 11, which provides this variable in the stock API [RH]
    var isAccessibilityCategory: Bool {
        switch self {
        case UIContentSizeCategory.accessibilityMedium,
             UIContentSizeCategory.accessibilityLarge,
             UIContentSizeCategory.accessibilityExtraLarge,
             UIContentSizeCategory.accessibilityExtraExtraLarge,
             UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return true
        default:
            return false
        }
    }
}
