import Foundation

enum FilesError: Error {
  case notFound(String)
}

class Files {
  
  private let fileManager = FileManager.default
  
  // MARK: - Folders

  var homeFolder: URL {
    return self.fileManager.homeDirectoryForCurrentUser
  }
  
  func readFolder(path: String) throws -> [URL] {
    let folderUrl = URL(fileURLWithPath: path, isDirectory: true)
    
    return try fileManager.contentsOfDirectory(atPath: path)
      .map { folderUrl.appendingPathComponent($0, isDirectory: false) }
      .filter { self.isYaml(path: $0) }
  }
  
  func createFolder(url: URL) throws {
    try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
  }
  
  // MARK: - Files
  
  func readFile(url: URL) throws -> String? {
    let data = try Data(contentsOf: url)
    return String(data: data, encoding: .utf8)
  }
  
  func write(files: [FileDescription]) throws {
    for file in files {
      let folder = file.url.deletingLastPathComponent()
      try createFolder(url: folder)
      try file.write()
    }
  }
  
  // MARK: - Private
  
  private func isYaml(path: URL) -> Bool {
    let allowedExtensions = ["yml", "yaml"]
    
    return allowedExtensions.contains(path.pathExtension)
  }
  
}
