import Foundation

public class Templates {
  
  private let files = Files()
  private let parser = TemplateParser()
  private let generator = TemplateGenerator()
  
  public init() { }
  
  // MARK: - Public
  
  public func run(args: [String]) throws {
    guard let runConfig = try CommandArgumentParser().parse(args: args) else {
      return
    }
    
    let files = try self.files.readFolder(path: runConfig.inputFolder)
    let outputFolder = self.outputFolder(runConfig: runConfig)

    for file in files {
      guard let string = try self.files.readFile(url: file) else {
        continue
      }

      let templateName = self.templateName(url: file)

      let template = try self.parser.parse(string: string)
      let templateFiles = try self.generator.generate(name: templateName,
                                                      template: template,
                                                      outputFolder: outputFolder)

      try self.files.write(files: templateFiles)
    }
  }
  
  // MARK: - Private
  
  func templateName(url: URL) -> String {
    return url.deletingPathExtension().lastPathComponent
  }
  
  private func outputFolder(runConfig: RunConfig) -> URL {
    if runConfig.outputFolder.isEmpty {
      return self.files.homeFolder.appendingPathComponent(Constants.templatesDestinationPath)
    }
    
    return URL(fileURLWithPath: runConfig.outputFolder, isDirectory: true)
  }
}
