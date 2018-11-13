import Darwin
import Foundation
import Yaml

let args = CommandLine.arguments
guard args.count > 1 else {
  exit(0)
}

do {
  let filePath = args[1]
  let string = try File.read(filePath: filePath)
  let name = File.fileName(path: filePath, removeExtension: true)
  let template = try TemplateParser.parse(name: name, string: string)

  try TemplateGenerator.generate(template: template)
} catch {
  print(error)
}
