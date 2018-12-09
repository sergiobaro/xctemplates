import Foundation
import Utility

class InstallCommandArgument: CommandArgument {
  
  private let inputFolderArgumentName = "input folder"
  
  required init(parser: ArgumentParser) {
    let installArgumentSubparser = parser.add(subparser: "install", overview: "install templates in library folder")
    let _ = installArgumentSubparser.add(positional: inputFolderArgumentName,
                                         kind: String.self,
                                         optional: false,
                                         usage: "where templates in yaml format are located",
                                         completion: nil)
  }
  
  func runConfig(from result: ArgumentParser.Result) throws -> RunConfig? {
    guard let installInputFolder: String = try result.get(inputFolderArgumentName) else {
      return nil
    }
    
    return RunConfig(type: .install,
                     inputFolder: installInputFolder,
                     outputFolder: "")
  }
  
}
