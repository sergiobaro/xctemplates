// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xctemplates",
  products: [
    .executable(name: "xctemplates", targets: ["xctemplates"]),
    .library(name: "Templates", targets: ["Templates"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.3.0"),
    .package(url: "https://github.com/behrang/YamlSwift.git", from: "3.0.0")
  ],
  targets: [
    .target(
      name: "xctemplates",
      dependencies: ["Templates"]),
    .target(
      name: "Templates",
      dependencies: ["Yaml", "Utility"]),
    .testTarget(
      name: "TemplatesTests",
      dependencies: ["Templates"]),
    ]
)
