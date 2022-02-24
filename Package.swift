// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ClickGesture",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .macCatalyst(.v13), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "ClickGesture",
            targets: ["ClickGesture"]),
    ],
    targets: [
        .target(
            name: "ClickGesture",
            dependencies: []),
    ]
)
