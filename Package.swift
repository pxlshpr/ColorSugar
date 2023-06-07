// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorSugar",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ColorSugar",
            targets: ["ColorSugar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pxlshpr/ColorKit", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ColorSugar",
            dependencies: [
                .product(name: "ColorKit", package: "ColorKit"),
            ]),
        .testTarget(
            name: "ColorSugarTests",
            dependencies: ["ColorSugar"]),
    ]
)
