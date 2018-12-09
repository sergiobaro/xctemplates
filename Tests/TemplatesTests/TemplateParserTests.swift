import XCTest
@testable import Templates

class TemplateParserTests: XCTestCase {
  
  var parser: TemplateParser!
  
  override func setUp() {
    super.setUp()
    
    self.parser = TemplateParser()
  }
  
  // MARK: - Tests
  
  func test_() {
    let string = """
    type: file
    description: An empty swift file
    file: |
      import Foundation
    """
    var template: Template?
    XCTAssertNoThrow(template = try parser.parse(string: string))
    
    XCTAssertNotNil(template)
    
    XCTAssertEqual(template?.type, TemplateType.file)
    XCTAssertEqual(template?.description, "An empty swift file")
    XCTAssertEqual(template?.fileContents, "import Foundation")
  }
  
  
}
