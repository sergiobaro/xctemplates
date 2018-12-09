import Foundation

enum TemplateOptionType: String {
  case text
  case popup
  case checkbox
}

struct TemplateOption {
  
  let type: TemplateOptionType
  let identifier: String
  let label: String?
  let description: String?
  let defaultValue: String?
  let required: Bool?
  let persisted: Bool?

}
