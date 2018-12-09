import Darwin
import Foundation
import Templates
import Utility

let args = Array(CommandLine.arguments.dropFirst())
let templates = Templates()

do {
  try templates.run(args: args)
} catch let error as ArgumentParserError {
  print(error.description)
} catch {
  print(error.localizedDescription)
}
