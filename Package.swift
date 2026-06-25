// swift-tools-version:5.9
import Foundation
import PackageDescription

let package = Package(
    name: "KSPlayer",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_15), .macCatalyst(.v14), .iOS(.v13), .tvOS(.v13),
                .visionOS(.v1)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KSPlayer",
            // todo clang: warning: using sysroot for 'iPhoneSimulator' but targeting 'MacOSX' [-Wincompatible-sysroot]
//            type: .dynamic,
            targets: ["KSPlayer"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        .target(
            name: "KSPlayer",
            dependencies: [
                .product(name: "FFmpegKit", package: "FFmpegKit"),
//                .product(name: "Libass", package: "FFmpegKit"),
//                .product(name: "Libmpv", package: "FFmpegKit"),
                "DisplayCriteria",
            ],
            resources: [.process("Metal/Shaders.metal")],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .target(
            name: "DisplayCriteria"
        ),
        .testTarget(
            name: "KSPlayerTests",
            dependencies: ["KSPlayer"],
            resources: [.process("Resources")]
        ),
    ]
)

// CobiPlayer-Fork: fest auf den LGPL-FFmpegKit-Fork verweisen — statt der lokalen
// Pfad-Autoerkennung (die ~/dev/FFmpegKit fand und als instabiles Local-Package
// einband) und statt kingslays GPL-Variante. So existiert nur EINE ffmpegkit-
// Identität → keine „conflicting identity", stabile (App-Store-taugliche) Auflösung.
package.dependencies += [
    .package(url: "https://github.com/Anthonidas/FFmpegKit.git", exact: "6.1.3"),
]
