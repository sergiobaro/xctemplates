import Foundation
import Utility

class CommandArgumentParser {
  
  private let parser: ArgumentParser
  private let commands: [CommandArgument]
  
  init() {
    let parser = ArgumentParser(commandName: "xctemplates",
                                usage: "<subcommand> <options>",
                                overview: "Parse and install yaml template files")
    self.commands = [
      ParseCommandArgument(parser: parser),
      InstallCommandArgument(parser: parser)
    ]
    
    self.parser = parser
  }
  
  func parse(args: [String]) throws -> RunConfig? {
    let result = try parser.parse(args)
    
    var i = 0
    var runConfig: RunConfig?
    
    while (runConfig == nil && i < self.commands.count) {
      let command = self.commands[i]
      runConfig = try command.runConfig(from: result)
      i += 1
    }
    
    return runConfig
  }
  
}
