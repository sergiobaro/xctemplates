import Foundation

class TemplateGenerator {
  
  static func generate(template: Template) throws {
    let url = pathForTemplate(template)
    try File.createDir(path: url.path)
    
    let templatePlist = generateTemplatePlist(template: template)
    let templateInfoUrl = File.url(with: "TemplateInfo.plist", relativeTo: url)
    
    try templatePlist.write(to: templateInfoUrl, atomically: true, encoding: .utf8)
  }
  
  static func generateTemplatePlist(template: Template) -> String {
    let header = """
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Kind</key>
        <string>Xcode.IDEFoundation.TextSubstitutionFileTemplateKind</string>
        <key>AllowedTypes</key>
        <array>
          <string>public.swift-source</string>
        </array>

    """
    let footer = """
      </dict>
      </plist>
    """
    
    return header + footer
  }
  
  private static func pathForTemplate(_ template: Template) -> URL {
    var templateDir = File.url(with: Constants.templatesDestinationPath)
    templateDir.appendPathComponent("\(template.name).xctemplate")
    
    return templateDir
  }
  
}
