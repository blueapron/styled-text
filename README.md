#  <img src='https://user-images.githubusercontent.com/4182788/29837864-703557a2-8cc7-11e7-9411-89def22ef0f3.png' width=100 align='center'>   StyledText   [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=599b31b30b95740001249898&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/599b31b30b95740001249898/build/latest?branch=master) 
StyledText is a library that simplifies styling dynamic text in iOS applications.  Instead of having to use attributed strings every time you need to update text, you can declaratively set a text style on your labels.  When the text of the label is updated, the label uses the preset style.

<p align='center'>
<img src='https://user-images.githubusercontent.com/4182788/28786080-1f616a70-75e6-11e7-84cc-7740406a365b.png' width=300 align='center'>
</p>

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

### Cocoapods

1. Add this line to your Podfile:

```
pod "StyledText"
```

2. Run a `pod install`
3. You're all set!

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate StyledText into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "blueapron/styled-text"
```

Run `carthage update` to build the framework and drag the built `StyledText.framework` into your Xcode project.

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

## Providing Defaults

You probably have a sensible default value for kerning that works well for your font.  Instead of needing to specify this kern value in each individual `TextStyle` you create, you can use a `TextStyleDefaultsGenerator` to add it automatically.  The simplest way to get started with this is to extend `TextStyle` to conform to the `TextStyleDefaultsGenerator` protocol, the library will detect if you've added this conformance and behave appropriately.

``` swift
extension TextStyle: TextStyleDefaultsGenerator {
    private static let defaultCeraKern: CGFloat = -0.2
    private static let defaultChronicleKern: CGFloat = -0.2

    static public func defaultKern(for font: UIFont) -> CGFloat? {
        if font.fontName.contains("Cera") {
            return defaultCeraKern
        } else if font.fontName.contains("Chronicle") {
            return defaultChronicleKern
        }
        return nil
    }
}
```

## Dynamic Type Support

<p align='center'>
<img src='https://user-images.githubusercontent.com/4182788/28786100-2fd9c528-75e6-11e7-8c5d-935598cf5147.gif' width=300 align='center'>
</p>

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
