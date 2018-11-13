import Foundation
import Yaml

enum TemplateType: String {
  case file
  case project
}

struct Template {
  
  let name: String
  let type: TemplateType
  let description: String?
  let fileContents: String?
  
}

enum TemplateParserError: Error {
  
  case missingProperty(String)
  case invalidPropertyValue(String)
  
}

class TemplateParser {
  
  static func parse(name: String, string: String) throws -> Template {
    let yaml = try Yaml.load(string)
    
    guard let typeString = yaml["type"].string else {
      throw TemplateParserError.missingProperty("type")
    }
    
    guard let type = TemplateType(rawValue: typeString) else {
      throw TemplateParserError.invalidPropertyValue("Value \(typeString) is invalid for property 'type'")
    }
    
    return Template(name: name,
                    type: type,
                    description: yaml["description"].string,
                    fileContents: yaml["file"].string)
  }
    
  
}
