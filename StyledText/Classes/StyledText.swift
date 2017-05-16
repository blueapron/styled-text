import Foundation

protocol StyledText {
    var style: TextStyle { get set }
    var styledAttributedStringValue: NSAttributedString { get }
}

struct StyledString: StyledText {
    let string: String
    var style: TextStyle

    var styledAttributedStringValue: NSAttributedString {
        return NSAttributedString(string: string, attributes: style.attributes)
    }
}

struct StyledAttributedString: StyledText {
    let attributedString: NSAttributedString
    var style: TextStyle

    var styledAttributedStringValue: NSAttributedString {
        guard let mutableString = attributedString.mutableCopy() as? NSMutableAttributedString else {
            return attributedString
        }

        func enumerator(attributes: [String: Any], range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) {
            var attributesToAdd = style.attributes
            // choosing existing string attributes if they exist over our style attributes [RH]
            attributes.forEach { (key, _) in
                attributesToAdd[key] = nil
            }
            mutableString.addAttributes(attributesToAdd, range: range)
        }

        let entireRange = NSRange(location: 0, length: mutableString.length)
        mutableString.enumerateAttributes(in: entireRange, options: [], using: enumerator)

        return mutableString
    }
}
