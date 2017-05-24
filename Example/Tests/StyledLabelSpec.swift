import Nimble
import Nimble_Snapshots
import Quick
import StyledText

fileprivate extension StyledLabel {
    static func testLabel() -> StyledLabel {
        let frame = CGRect(origin: .zero, size: .zero)
        let label = StyledLabel(frame: frame)
        label.text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()<>?:{}|[];',."
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }

    static func testMultilineLabel() -> StyledLabel {
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        let label = StyledLabel(frame: frame)
        label.text = "StyledText\nStyledText\nStyledText"
        label.numberOfLines = 0
        return label
    }
}

fileprivate extension TextStyle {
    static var standard: TextStyle { return TextStyle(font: .systemFont(ofSize: 12), color: .black) }
}

class StyledLabelSpec: QuickSpec {
    override func spec() {
        describe("StyledLabel") {
            it("respects font") {
                let label = StyledLabel.testLabel()
                label.textStyle = TextStyle.standard
                expect(label).to(haveValidSnapshot(named: "font-regular"))
                label.textStyle = TextStyle.standard.with(font: .italicSystemFont(ofSize: 12))
                expect(label).to(haveValidSnapshot(named: "font-italic"))
                label.textStyle = TextStyle.standard.with(font: .boldSystemFont(ofSize: 12))
                expect(label).to(haveValidSnapshot(named: "font-bold"))
            }

            it("respects color") {
                let label = StyledLabel.testLabel()
                label.textStyle = TextStyle.standard.with(color: .red)
                expect(label).to(haveValidSnapshot(named: "color-red"))
                label.textStyle = TextStyle.standard.with(color: .green)
                expect(label).to(haveValidSnapshot(named: "color-green"))
                label.textStyle = TextStyle.standard.with(color: .blue)
                expect(label).to(haveValidSnapshot(named: "color-blue"))
            }

            it("respects kerning") {
                let label = StyledLabel.testLabel()
                label.textStyle = TextStyle.standard.with(kern: 1.0)
                expect(label).to(haveValidSnapshot(named: "kern-medium"))
                label.textStyle = TextStyle.standard.with(kern: 5.0)
                expect(label).to(haveValidSnapshot(named: "kern-large"))
                label.textStyle = TextStyle.standard.with(kern: -2.0)
                expect(label).to(haveValidSnapshot(named: "kern-negative"))
            }

            it("respects line spacing") {
                let label = StyledLabel.testMultilineLabel()
                label.textStyle = TextStyle.standard.with(lineSpacing: 1.0)
                expect(label).to(haveValidSnapshot(named: "line-spacing-medium"))
                label.textStyle = TextStyle.standard.with(lineSpacing: 5.0)
                expect(label).to(haveValidSnapshot(named: "line-spacing-large"))
                label.textStyle = TextStyle.standard.with(lineSpacing: -2.0)
                expect(label).to(haveValidSnapshot(named: "line-spacing-negative"))
            }

            it("respects line height multiple") {
                let label = StyledLabel.testMultilineLabel()
                label.textStyle = TextStyle.standard.with(lineHeightMultiple: 2.0)
                label.sizeToFit()
                expect(label).to(haveValidSnapshot(named: "line-height-multiple-double"))
                label.textStyle = TextStyle.standard.with(lineHeightMultiple: 3.0)
                label.sizeToFit()
                expect(label).to(haveValidSnapshot(named: "line-height-multiple-triple"))
                label.textStyle = TextStyle.standard.with(lineHeightMultiple: 0.5)
                label.sizeToFit()
                expect(label).to(haveValidSnapshot(named: "line-height-multiple-half"))
            }

            it("respects word wrapping") {
                // TODO 
            }
        }
    }
}
