// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "IDnowEID",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "IDnowEID",
            targets: ["IDnowEID"]
        ),
        .library(
            name: "IDnowEIDDynamic",
            targets: ["IDnowEIDDynamicWrapper"]
        ),
        .library(
            name: "IDnowEIDGovernikus",
            targets: ["IDnowEIDGovernikusWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", exact: "3.6.1"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.4"),
        .package(url: "https://github.com/Governikus/AusweisApp2-SDK-iOS.git", exact: "2.2.2")
    ],
    targets: [
        .binaryTarget(
            name: "IDnowEID",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.4.0/IDnowEID.xcframework.zip",
            checksum: "5d3cac803779e3674fca4d0424d563f8f53f2b7738cfe351480be3aad2ba11c3"
        ),
        .binaryTarget(
            name: "IDnowEIDDynamic",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.4.0/IDnowEIDDynamic.xcframework.zip",
            checksum: "eda39502606efd0f38b1bb28c35f384b8908e40498d322c8956013a9ac9f7fff"
        ),
        .binaryTarget(
            name: "IDnowEIDGovernikus",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.4.0/IDnowEIDGovernikus.xcframework.zip",
            checksum: "0541fa8b0b02ae38730b4bd48fa583ea799e2e1c8c75cb4d85de82f98a9139d4"
        ),
        .target(
            name: "IDnowEIDDynamicWrapper",
            dependencies: [
                "IDnowEIDDynamic",
                .product(name: "OpenSSL", package: "OpenSSL"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources-dynamic"
        ),
        .target(
            name: "IDnowEIDGovernikusWrapper",
            dependencies: [
                "IDnowEIDGovernikus",
                .product(name: "OpenSSL", package: "OpenSSL"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios"),
                .product(name: "AusweisApp2", package: "AusweisApp2-SDK-iOS")
            ],
            path: "sources-governikus"
        )
    ]
)
