import XCTest
@testable import SwiftPDF

final class SwiftPDFTests: XCTestCase {
    
    func testTextTooBig() throws {
        let tree = DebugTree {
            HStack {
                Color.black
                Text("Text, als größtes Element im HStack.")
                Color.black
            }
            .frame(width: 500)
        }
        
        let node = tree.firstNode(ofType: TextNode.self)
        let textNode = try XCTUnwrap(node)
        XCTAssertEqual(textNode.lines, 2)
    }
    
    func testTextSmallEnough() throws {
        let tree = DebugTree {
            HStack {
                Color.black
                Text("Text kleinstes Element in HStack")
                Color.black
            }
            .frame(width: 1000)
        }
        
        let node = tree.firstNode(ofType: TextNode.self)
        let textNode = try XCTUnwrap(node)
        XCTAssertEqual(textNode.lines, 1)
    }
}
