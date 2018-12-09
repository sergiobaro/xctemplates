import Foundation
import Utility

enum CommandType {
  
  case install
  case parse
  
}

struct RunConfig {
  
  let type: CommandType
  let inputFolder: String
  let outputFolder: String
  
}

protocol CommandArgument {
  
  init(parser: ArgumentParser)
  
  func runConfig(from result: ArgumentParser.Result) throws -> RunConfig?
  
}
