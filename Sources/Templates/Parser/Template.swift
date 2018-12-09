import Foundation

enum TemplateType: String {
  case file
  case project
}

struct Template {
  
  let type: TemplateType
  let description: String?
  let fileContents: String?
  
}
