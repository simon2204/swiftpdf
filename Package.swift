// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPDFUI",
    products: [
        .library(
            name: "SwiftPDFUI",
            targets: ["SwiftPDFUI"]),
    ],
    targets: [
		.target(
			name: "SwiftPDF"
		),
        .target(
            name: "SwiftPDFUI",
			dependencies: ["SwiftPDF"]
        ),
        .executableTarget(
            name: "SwiftPDFMain",
            dependencies: ["SwiftPDF"]
		),
		.executableTarget(
			name: "SwiftPDFUIMain",
			dependencies: ["SwiftPDFUI"]
		),
        .testTarget(
            name: "SwiftPDFUITests",
            dependencies: ["SwiftPDFUI"]),
    ]
)
