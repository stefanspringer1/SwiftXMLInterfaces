// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XMLInterfaces",
    products: [
        .library(
            name: "XMLInterfaces",
            targets: ["XMLInterfaces"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "XMLInterfaces",
            dependencies: [])
    ]
)
