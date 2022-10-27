// swift-tools-version:5.3
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
        .package(url: "https://github.com/stefanspringer1/AutoreleasepoolShim", from: "1.0.1"),
    ],
    targets: [
        .target(
            name: "SwiftXMLInterfaces",
            dependencies: [
                "AutoreleasepoolShim",
            ])
    ]
)
