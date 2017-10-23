// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ResxSwift

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        
        let bundle = Bundle(for: TableOfContentsSpec.self)
        guard let filePath_en = bundle.path(forResource: "Resource.en", ofType: "resx") else { fatalError("File load error") }
        guard let filePath_sv = bundle.path(forResource: "Resource.sv", ofType: "resx") else { fatalError("File load error") }
        
        let fileURL_en = URL(fileURLWithPath: filePath_en)
        let fileURL_sv = URL(fileURLWithPath: filePath_sv)
        
        describe("these will fail") {

            context("these will pass") {

                it("can load resource") {
                    let resx = ResxSwift()
                    try! resx.load(fileURL: URL.init(fileURLWithPath: filePath_en), language: "en")
                    expect(resx.localizedString("Exception_Authorization_Username_Not_Found", language: "en")) == "User not exists."
                }
                
                it("can load multiple languages") {
                    let resx = ResxSwift()
                    try! resx.load(fileURL: fileURL_en, language: "en")
                    try! resx.load(fileURL: fileURL_sv, language: "sv")
                    
                    expect(resx.localizedString("Exception_Authorization_Username_Not_Found", language: "en")) == "User not exists."
                    expect(resx.localizedString("Exception_Authorization_Username_Not_Found", language: "sv")) == "Användaren finns inte."
                }
                
                it("will fallback to key if value not found") {
                    let resx = ResxSwift()
                    try! resx.load(fileURL: fileURL_en, language: "en")
                    
                    expect(resx.localizedString("🍌", language: "en")) == "🍌"
                }
            }
        }
    }
}
