#if canImport(UIKit)

public protocol DynamicTypeControllerDelegate: class {
    func preferredContentSizeCategoryDidUpdate(controller: DynamicTypeController, newCategory: UIContentSizeCategory)
}

public class DynamicTypeController {
    public static let shared = DynamicTypeController(loadSavedContentSize: true)

    private var contentSizeCategoryObservation: AnyObject?

    public init(loadSavedContentSize: Bool = false) {
        if loadSavedContentSize,
            let string = UserDefaults.standard.string(forKey: DynamicTypeController.DefaultsKey) {
            let category = UIContentSizeCategory(rawValue: string)
            overrideContentSizeCategory = category
        }

        contentSizeCategoryObservation = NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: .main) { [weak self] notification in
            self?.contentSizeCategoryDidChange()
        }
    }

    deinit {
        if let observation = contentSizeCategoryObservation {
            NotificationCenter.default.removeObserver(observation)
        }
    }

    // MARK: - Scaling Fonts
    public func adjustFontForDynamicSize(font: UIFont, supportAccessibiltySizes: Bool = false) -> UIFont {
        var contentSize = self.contentSize
        if contentSize.isAccessibilityCategory && supportAccessibiltySizes == false {
            contentSize = .extraExtraExtraLarge
        }

        // We get these default scaling factors from comparing sizes of iOS Body text to the default
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

        let integralScaledSize = round(font.pointSize * scaleFactor)
        return font.withSize(integralScaledSize)
    }

    // MARK: - Override Content Size
    public var contentSize: UIContentSizeCategory {
        return overrideContentSizeCategory ?? UIApplication.shared.preferredContentSizeCategory
    }

    private static let DefaultsKey = "StyledTextOverrideContentSize"
    public var overrideContentSizeCategory: UIContentSizeCategory? {
        didSet {
            UserDefaults.standard.set(overrideContentSizeCategory?.rawValue, forKey: DynamicTypeController.DefaultsKey)
            contentSizeCategoryDidChange()
        }
    }

    // MARK: - Content Size Changes
    private let delegates = WeakArray<DynamicTypeControllerDelegate>()

    public func addDelegate(_ delegate: DynamicTypeControllerDelegate) {
        delegates.append(element: delegate)
    }

    private func contentSizeCategoryDidChange() {
        delegates.forEach { delegate in
            delegate.preferredContentSizeCategoryDidUpdate(controller: self, newCategory: contentSize)
        }
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

#endif
