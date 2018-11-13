// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xctemplates",
    dependencies: [
        .package(url: "https://github.com/behrang/YamlSwift.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "xctemplates",
            dependencies: ["Yaml"]),
        .testTarget(
            name: "xctemplatesTests",
            dependencies: ["xctemplates"]),
    ]
)
