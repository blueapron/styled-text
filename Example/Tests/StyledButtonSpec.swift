import Nimble
import Nimble_Snapshots
import Quick
import StyledText

fileprivate extension StyledButton {
    static func testButton() -> StyledButton {
        let button = StyledButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 44.0)
        button.setTitle("ABCDEFabcdef", for: .normal)
        return button
    }
}

fileprivate extension TextStyle {
    static var standard: TextStyle { return TextStyle(font: .systemFont(ofSize: 12), color: .black) }
}

class StyledButtonSpec: QuickSpec {
    override func spec() {
        describe("StyledButton") {
            it("respects font") {
                let button = StyledButton.testButton()
                button.normalTextStyle = TextStyle.standard
                expect(button).to(haveValidSnapshot(named: "font-regular"))
                button.normalTextStyle = TextStyle.standard.with(font: .italicSystemFont(ofSize: 12))
                expect(button).to(haveValidSnapshot(named: "font-italic"))
                button.normalTextStyle = TextStyle.standard.with(font: .boldSystemFont(ofSize: 12))
                expect(button).to(haveValidSnapshot(named: "font-bold"))
            }

            it("respects color") {
                let button = StyledButton.testButton()
                button.normalTextStyle = TextStyle.standard.with(color: .red)
                expect(button).to(haveValidSnapshot(named: "color-red"))
                button.normalTextStyle = TextStyle.standard.with(color: .green)
                expect(button).to(haveValidSnapshot(named: "color-green"))
                button.normalTextStyle = TextStyle.standard.with(color: .blue)
                expect(button).to(haveValidSnapshot(named: "color-blue"))
            }

            it("respects kerning") {
                let button = StyledButton.testButton()
                button.normalTextStyle = TextStyle.standard.with(kern: 1.0)
                expect(button).to(haveValidSnapshot(named: "kern-medium"))
                button.normalTextStyle = TextStyle.standard.with(kern: 5.0)
                expect(button).to(haveValidSnapshot(named: "kern-large"))
                button.normalTextStyle = TextStyle.standard.with(kern: -2.0)
                expect(button).to(haveValidSnapshot(named: "kern-negative"))
            }
        }
    }
}
