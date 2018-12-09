import Foundation

class TemplateGenerator {
  
  func generate(name: String, template: Template, outputFolder: URL) throws -> [FileDescription] {
    var files = [FileDescription]()
    
    let templateFolder = outputFolder.appendingPathComponent("\(name).xctemplate", isDirectory: true)

    let templatePlist = self.generateTemplatePlist(template: template)
    let templateInfoUrl = templateFolder.appendingPathComponent("TemplateInfo.plist", isDirectory: false)

    files.append(PlistFileDescription(url: templateInfoUrl, dictionary: templatePlist))

    if let contents = template.fileContents {
      let fileUrl = templateFolder.appendingPathComponent("___FILEBASENAME___.swift", isDirectory: false)
      files.append(StringFileDescription(url: fileUrl, string: contents))
    }
    
    return files
  }
  
  // MARK: - Private
  
  private func generateTemplatePlist(template: Template) -> NSDictionary {
    let dict = NSMutableDictionary()
    
    dict["Kind"] = "Xcode.IDEFoundation.TextSubstitutionFileTemplateKind"
    dict["AllowedTypes"] = ["public.swift-source"]
    dict["DefaultCompletionName"] = "File"
    dict["MainTemplateFile"] = "___FILEBASENAME___.swift"
    dict["Platforms"] = ["com.apple.platform.iphoneos"]
    
    return dict
  }
  
}
