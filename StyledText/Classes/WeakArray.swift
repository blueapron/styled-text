import Foundation

// `WeakArray` stores a collection of weakly-referenced pointers
// Useful for multiple delegation patterns
internal class WeakArray<Element> {
    private struct WeakElement {
        private weak var _value: AnyObject?
        // Swift doesn't like constraining Element to AnyObject, so this will have to do
        var value: Element? {
            get {
                return _value as? Element
            }
            set {
                _value = newValue as AnyObject?
            }
        }
        init(value: Element) {
            self.value = value
        }
    }

    private var contents: [WeakElement] = []

    // MARK: Public API

    func append(element: Element) {
        let weakElement = WeakElement(value: element)
        contents.append(weakElement)
    }

    func forEach(doBlock: (Element) -> Void) {
        // clean up any deallocated items first
        contents = contents.flatMap { $0.value != nil ? $0 : nil }

        for i in contents.startIndex..<contents.endIndex {
            if let value = contents[i].value {
                doBlock(value)
            }
        }
    }
}
