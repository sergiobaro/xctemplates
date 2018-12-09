import Foundation
import Utility

struct ParseCommandArgument: CommandArgument {
  
  private let inputFolderArgumentName = "input folder"
  private let outputFolderArgumentName = "output folder"
  
  init(parser: ArgumentParser) {
    let subparser = parser.add(subparser: "parse", overview: "transform templates from yaml to xcode format")
    let _ = subparser.add(positional: inputFolderArgumentName,
                          kind: String.self,
                          optional: false,
                          usage: "where templates in yaml format are located",
                          completion: nil)
    let _ = subparser.add(positional: outputFolderArgumentName,
                          kind: String.self,
                          optional: false,
                          usage: "where templates in xcode format will be saved",
                          completion: nil)
  }
  
  
  func runConfig(from result: ArgumentParser.Result) throws -> RunConfig? {
    guard let parseInputFolder: String = try result.get(inputFolderArgumentName),
      let parseOutputFolder: String = try result.get(outputFolderArgumentName) else {
        return nil
    }
    return RunConfig(type: .parse,
                     inputFolder: parseInputFolder,
                     outputFolder: parseOutputFolder)
  }
  
}
