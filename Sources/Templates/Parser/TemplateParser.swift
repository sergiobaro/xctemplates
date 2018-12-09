import Foundation
import Yaml

enum TemplateParserError: Error {
  
  case missingProperty(String)
  case invalidPropertyValue(String)
  case missingPropertyInOption(String)
  case invalidOptionType(String)
  
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
    
    let options = try self.parseOptions(yaml["options"])
    
    return Template(type: type,
                    description: yaml["description"].string,
                    fileContents: yaml["file"].string,
                    options: options)
  }
  
  func parseOptions(_ yaml: Yaml) throws -> [TemplateOption] {
    guard let options = yaml.array else {
      return []
    }
    
    return try options.compactMap({ yaml in
      guard let typeString = yaml["type"].string else {
        throw TemplateParserError.missingPropertyInOption("type")
      }
      guard let type = TemplateOptionType(rawValue: typeString) else {
        throw TemplateParserError.invalidOptionType("Value \(typeString) is invalid for property 'type'")
      }
      guard let identifier = yaml["identifier"].string else {
        throw TemplateParserError.missingPropertyInOption("identifier")
      }
      
      let label = yaml["label"].string
      let description = yaml["description"].string
      let defaultValue = yaml["defaultValue"].string
      let required = yaml["required"].bool
      let persisted = yaml["persisted"].bool
      
      return TemplateOption(type: type,
                            identifier: identifier,
                            label: label,
                            description: description,
                            defaultValue: defaultValue,
                            required: required,
                            persisted: persisted)
    })
  }

}
