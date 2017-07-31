# StyledText
StyledText is a library that simplifies styling dynamic text in iOS applications.  Instead of having to use attributed strings every time you need to update text, you can declaratively set a text style on your labels.  When the text of the label is updated, the label uses the preset style.

## Before

``` swift
let label = UILabel()
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.lineSpacing = 4.0
let attributes: [String: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14),
                                 NSForegroundColorAttributeName: UIColor.blue,
                                 NSKernAttributeName: 1.5,
                                 NSParagraphStyleAttributeName: paragraphStyle]

let string = NSAttributedString(string: "This is a string",
                                attributes: attributes)
label.attributedText = string
let newString = NSAttributedString(string: "This is a new string",
                                   attributes: attributes)
label.attributedText = newString
```

## After

``` swift
let styledLabel = StyledLabel()
styledLabel.textStyle = TextStyle(font: .boldSystemFont(ofSize: 14), color: .blue, lineSpacing: 4.0, kern: 1.5)
styledLabel.text = "This is a string"
styledLabel.text = "This is a new string"
```

# Installation

1. Add this line to your Podfile:

```
pod "StyledText"
```

2. Run a `pod install`
3. You're all set!

# How to Use

Getting started with StyledText is easy, just add a `StyledLabel` to your view and provide it with a `TextStyle`.  After that, it behaves like any other `UILabel`.  Changes to the label's `text` property will always use the set `textStyle`.

``` swift
class ViewController: UIViewController {
    private let styledLabel: StyledLabel = {
        let label = StyledLabel(frame: .zero)
        label.textStyle = TextStyle(font: .boldSystemFont(ofSize: 24.0),
                                    color: .orange)
        return label
    }()
}
```

## TextStyle

A `TextStyle` represents the attributes a styled view should use to draw its text.  Many different text formatting options are supported, including those that previously required interaction with attributed strings or paragraph styles, such as kerning and line spacing.  Creating a `TextStyle` is easy, just specify a font along with any other attributes you want to define.  Any unspecified attributes simply remain as system defaults.

``` swift
let style = TextStyle(font: .italicSystemFont(ofSize: 72),
                      color: .magenta,
                      lineSpacing: 10,
                      lineHeightMultiple: 2.0,
                      kern: -0.5,
                      alignment: .left,
                      lineBreakMode: .byTruncatingMiddle)

let blueStyle = style.with(color: .blue)
let redStyle = style.with(color: .red)
```

## Dynamic Type Support

StyledText supports scaling text content to the system font size, a feature Apple calls [Dynamic Type](https://useyourloaf.com/blog/supporting-dynamic-type/).  To use this feature, set the `dynamicTypeBehavior` property of a `TextStyle` to one of these values:

* `noScaling`: [default] keep the font size constant, even when the system font size changes
* `scaleToStandardSizes`: scale the font to all standard system font sizes, larger accessibility sizes are capped at the maximum standard size
* `scaleToAllSizes`: scale the font to all standard and accessiblity font sizes

It's possible for the font size to change while your application is running.  When this occurs, you'll need to call `refreshStyle()` on any styled components that are visible for the size to update.  A good way to listen for this event is by adding a delegate to the shared `DynamicTypeController`:

```swift
class MyViewController: UIViewController, DynamicTypeControllerDelegate {
    let label: StyledLabel = {
        let label = StyledLabel()
        label.textStyle = TextStyle(font: .boldSystemFont(ofSize: 14), color: .black, dynamicTypeBehavior: .scaleToStandardSizes)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        DynamicTypeController.shared.addDelegate(self)
    }

    func preferredContentSizeCategoryDidUpdate(controller: DynamicTypeController, newCategory: UIContentSizeCategory){
        label.refreshStyle()
    }
}
```

## Styled Components

To enable automatic styling, StyledText uses a number of view subclasses that are simple swap-in replacements for conventional UIKit components.

| StyledText View | Replaces UIKit View |
| --------------- | ------------------- |
| StyledLabel     | UILabel             |
| StyledTextView  | UITextView          |
| StyledButton*   | UIButton            |

### [*] Using StyledButton

`StyledButton` provides text style properties for each `UIControlState` button state.

| Control State | Text Style Property  |
| ------------- | -------------------- |
| .normal       | normalTextStyle      |
| .highlighted  | highlightedTextStyle |
| .disabled     | disabledTextStyle    |
| .selected     | selectedTextStyle    |

# License

StyledText is available under the MIT license. See the LICENSE file for more info.
