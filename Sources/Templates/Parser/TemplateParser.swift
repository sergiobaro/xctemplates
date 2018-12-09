import Foundation
import Yaml

enum TemplateParserError: Error {
  
  case missingProperty(String)
  case invalidPropertyValue(String)
  
}

class TemplateParser {
  
  func parse(string: String) throws -> Template {
    let yaml = try Yaml.load(string)
    
    guard let typeString = yaml["type"].string else {
      throw TemplateParserError.missingProperty("type")
    }
    
    guard let type = TemplateType(rawValue: typeString) else {
      throw TemplateParserError.invalidPropertyValue("Value \(typeString) is invalid for property 'type'")
    }
    
    return Template(type: type,
                    description: yaml["description"].string,
                    fileContents: yaml["file"].string)
  } 
  
}
