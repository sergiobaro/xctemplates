import XCTest
@testable import Templates

class CommandArgumentParserTests: XCTestCase {
  
  let parser = CommandArgumentParser()
  
  func test_noArguments_doesNothing() {
    XCTAssertNoThrow(try parser.parse(args: []))
  }
  
  func test_wrongArguments_throwsError() {
    XCTAssertThrowsError(try parser.parse(args: [""]))
  }
  
  func test_installArgument() {
    let args = "install input".components(separatedBy: " ")
    
    var runConfig: RunConfig?
    XCTAssertNoThrow(runConfig = try parser.parse(args: args))
    
    XCTAssertNotNil(runConfig)
    XCTAssertEqual(runConfig?.type, CommandType.install)
    XCTAssertEqual(runConfig?.inputFolder, "input")
    XCTAssertEqual(runConfig?.outputFolder, "")
  }
  
  func test_parseArgument() {
    let args = "parse input output".components(separatedBy: " ")
    
    var runConfig: RunConfig?
    XCTAssertNoThrow(runConfig = try parser.parse(args: args))
    
    XCTAssertNotNil(runConfig)
    XCTAssertEqual(runConfig?.type, CommandType.parse)
    XCTAssertEqual(runConfig?.inputFolder, "input")
    XCTAssertEqual(runConfig?.outputFolder, "output")
  }
}
