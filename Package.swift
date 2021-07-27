// swift-tools-version:5.4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftXMLInterfaces",
    products: [
        .library(
            name: "SwiftXMLInterfaces",
            targets: ["SwiftXMLInterfaces"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftXMLInterfaces",
            dependencies: [])
    ]
)
