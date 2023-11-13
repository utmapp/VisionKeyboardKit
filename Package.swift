// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "VisionKeyboardKit",
    platforms: [
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "VisionKeyboardKit",
            targets: ["VisionKeyboardKit"]),
    ],
    targets: [
        .target(
            name: "VisionKeyboardKit"),
        .testTarget(
            name: "VisionKeyboardKitTests",
            dependencies: ["VisionKeyboardKit"]),
    ]
)
