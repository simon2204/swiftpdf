// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPDF",
    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        .library(
            name: "SwiftPDF",
            targets: ["SwiftPDF"]),
    ],
    targets: [
		.target(
			name: "SwiftPDFFoundation"
		),
        .target(
            name: "SwiftPDF",
			dependencies: ["SwiftPDFFoundation"]
        ),
        .executableTarget(
            name: "SwiftPDFFoundationMain",
            dependencies: ["SwiftPDFFoundation"]
		),
		.executableTarget(
			name: "SwiftPDFMain",
			dependencies: ["SwiftPDF"]
		),
        .testTarget(
            name: "SwiftPDFTests",
            dependencies: ["SwiftPDF"]),
    ]
)
