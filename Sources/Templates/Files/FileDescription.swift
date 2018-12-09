import Foundation

protocol FileDescription {
  
  var url: URL { get }
  
  func write() throws
  
}

struct StringFileDescription: FileDescription {
  
  let url: URL
  let string: String
 
  func write() throws {
    try string.write(to: url, atomically: true, encoding: .utf8)
  }
}

struct PlistFileDescription: FileDescription {
  
  let url: URL
  let dictionary: NSDictionary
  
  func write() throws {
    dictionary.write(to: url, atomically: true)
  }
  
}
