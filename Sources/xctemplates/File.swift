import Foundation

enum FileError: Error {
  case notFound(String)
}

class File {
  
  static let manager = FileManager.default
  static let home = URL(fileURLWithPath: NSHomeDirectory())
  
  // MARK: - Folders
  
  static func createDir(path: String) throws {
    let url = URL(fileURLWithPath: path, isDirectory: true, relativeTo: home)
    try manager.createDirectory(at: url, withIntermediateDirectories: true)
  }
  
  // MARK: - Files
  
  static func read(filePath: String) throws -> String {
    let url = home.appendingPathComponent(filePath)
    
    guard manager.fileExists(atPath: url.path) else {
      throw FileError.notFound(url.path)
    }
    
    do {
      let data = try Data(contentsOf: url)
      return String(data: data, encoding: .utf8) ?? ""
    } catch {
      throw error
    }
  }
  
  // MARK: - Urls
  
  static func url(with path: String, relativeTo url: URL? = nil) -> URL {
    return URL(fileURLWithPath: path, relativeTo: url ?? home)
  }
  
  static func fileName(path: String, removeExtension: Bool = false) -> String {
    var url = URL(fileURLWithPath: path)
    if removeExtension {
      url = url.deletingPathExtension()
    }
    
    return url.lastPathComponent
  }
}
