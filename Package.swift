// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Conekta",
    products: [
        .library(
            name: "Conekta",
            targets: ["Conekta"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Conekta",
            dependencies: []),
        .testTarget(
            name: "ConektaTests",
            dependencies: ["Conekta"]),
    ]
)
