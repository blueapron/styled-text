import Nimble
import Nimble_Snapshots
import Quick
import StyledText

fileprivate extension StyledTextView {
    static func testTextView() -> StyledTextView {
        let frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 320))
        let textView = StyledTextView(frame: frame)
        textView.text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()<>?:{}|[];',."
        return textView
    }

    static func testMultilineTextView() -> StyledTextView {
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        let textView = StyledTextView(frame: frame)
        textView.text = "StyledText\nStyledText\nStyledText"
        return textView
    }

    static func testLineBreakTextView() -> StyledTextView {
        let frame = CGRect(origin: .zero, size: .zero)
        let textView = StyledTextView(frame: frame)
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        textView.sizeToFit()
        textView.frame = textView.frame.divided(atDistance: 150, from: .minXEdge).slice
        return textView
    }
}

fileprivate extension TextStyle {
    static var standard: TextStyle { return TextStyle(font: .systemFont(ofSize: 12), color: .black) }
}

// replace haveValidSnapshot() with haveValidSnapshot() to test

class StyledTextViewSpec: QuickSpec {
    override func spec() {
        describe("StyledTextView") {
            it("respects font") {
                let textView = StyledTextView.testTextView()
                textView.textStyle = TextStyle.standard
                expect(textView).to(haveValidSnapshot(named: "font-regular"))
                textView.textStyle = TextStyle.standard.with(font: .italicSystemFont(ofSize: 12))
                expect(textView).to(haveValidSnapshot(named: "font-italic"))
                textView.textStyle = TextStyle.standard.with(font: .boldSystemFont(ofSize: 12))
                expect(textView).to(haveValidSnapshot(named: "font-bold"))
            }

            it("respects color") {
                let textView = StyledTextView.testTextView()
                textView.textStyle = TextStyle.standard.with(color: .red)
                expect(textView).to(haveValidSnapshot(named: "color-red"))
                textView.textStyle = TextStyle.standard.with(color: .green)
                expect(textView).to(haveValidSnapshot(named: "color-green"))
                textView.textStyle = TextStyle.standard.with(color: .blue)
                expect(textView).to(haveValidSnapshot(named: "color-blue"))
            }

            it("respects kerning") {
                let textView = StyledTextView.testTextView()
                textView.textStyle = TextStyle.standard.with(kern: 1.0)
                expect(textView).to(haveValidSnapshot(named: "kern-medium"))
                textView.textStyle = TextStyle.standard.with(kern: 5.0)
                expect(textView).to(haveValidSnapshot(named: "kern-large"))
                textView.textStyle = TextStyle.standard.with(kern: -2.0)
                expect(textView).to(haveValidSnapshot(named: "kern-negative"))
            }

            it("respects line spacing") {
                let textView = StyledTextView.testMultilineTextView()
                textView.textStyle = TextStyle.standard.with(lineSpacing: 1.0)
                expect(textView).to(haveValidSnapshot(named: "line-spacing-medium"))
                textView.textStyle = TextStyle.standard.with(lineSpacing: 5.0)
                expect(textView).to(haveValidSnapshot(named: "line-spacing-large"))
                textView.textStyle = TextStyle.standard.with(lineSpacing: -2.0)
                expect(textView).to(haveValidSnapshot(named: "line-spacing-negative"))
            }

            it("respects line height multiple") {
                let textView = StyledTextView.testMultilineTextView()
                textView.textStyle = TextStyle.standard.with(lineHeightMultiple: 2.0)
                textView.sizeToFit()
                expect(textView).to(haveValidSnapshot(named: "line-height-multiple-double"))
                textView.textStyle = TextStyle.standard.with(lineHeightMultiple: 3.0)
                textView.sizeToFit()
                expect(textView).to(haveValidSnapshot(named: "line-height-multiple-triple"))
                textView.textStyle = TextStyle.standard.with(lineHeightMultiple: 0.5)
                textView.sizeToFit()
                expect(textView).to(haveValidSnapshot(named: "line-height-multiple-half"))
            }

            it("respects line break mode") {
                let textView = StyledTextView.testLineBreakTextView()
                textView.textStyle = TextStyle.standard.with(lineBreakMode: .byClipping)
                expect(textView).to(haveValidSnapshot(named: "line-break-clipping"))
                textView.textStyle = TextStyle.standard.with(lineBreakMode: .byTruncatingHead)
                expect(textView).to(haveValidSnapshot(named: "line-break-truncate-head"))
                textView.textStyle = TextStyle.standard.with(lineBreakMode: .byTruncatingTail)
                expect(textView).to(haveValidSnapshot(named: "line-break-truncate-tail"))
                textView.textStyle = TextStyle.standard.with(lineBreakMode: .byWordWrapping)
                expect(textView).to(haveValidSnapshot(named: "line-break-word-wrap"))
            }
        }
    }
}
