// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPDFUI",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "SwiftPDFUI",
            targets: ["SwiftPDFUI"]),
    ],
    targets: [
        .target(
            name: "SwiftPDFUI",
            dependencies: []),
        .executableTarget(
            name: "PDFUIMain",
            dependencies: ["SwiftPDFUI"]),
        .testTarget(
            name: "SwiftPDFUITests",
            dependencies: ["SwiftPDFUI"]),
    ]
)
