import Nimble
import Nimble_Snapshots
import Quick
import StyledText

fileprivate extension StyledLabel {
    static func testLabel() -> StyledLabel {
        let frame = CGRect(origin: .zero, size: CGSize(width: 300.0, height: 300.0))
        let label = StyledLabel(frame: frame)
        label.text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()<>?:{}|[];',."
        return label
    }
}

class StyledLabelSpec: QuickSpec {
    override func spec() {
        describe("StyledLabel") {
            it("can respect font") {
                let label = StyledLabel.testLabel()
                label.textStyle = TextStyle(font: .italicSystemFont(ofSize: 12), color: .black)
                expect(label).to(haveValidSnapshot())
            }
        }
    }
}
