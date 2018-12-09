import Foundation

extension Dictionary where Key == String, Value == Any {
  
  mutating func add(key: Key, value: Value?) {
    if value != nil {
      self[key] = value!
    }
  }
}
