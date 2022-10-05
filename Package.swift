// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StyledText",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "StyledText",
            targets: ["StyledText"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StyledText",
            dependencies: [],
            path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
