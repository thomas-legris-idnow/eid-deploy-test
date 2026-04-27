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
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.8"),
        .package(url: "https://github.com/Governikus/AusweisApp2-SDK-iOS.git", exact: "2.2.2")
    ],
    targets: [
        .binaryTarget(
            name: "IDnowEID",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/4.0.0/IDnowEID.xcframework.zip",
            checksum: "84af81b2bc0cd8b44781d729509f5759ebc150062ceb38ed7e5a6061efc525bb"
        ),
        .binaryTarget(
            name: "IDnowEIDDynamic",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/4.0.0/IDnowEIDDynamic.xcframework.zip",
            checksum: "3fe5df6aceb2689d7f09d056568d14bf6cbb07bac3b8b702f78b71b4ae98c890"
        ),
        .binaryTarget(
            name: "IDnowEIDGovernikus",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/4.0.0/IDnowEIDGovernikus.xcframework.zip",
            checksum: "27e19e4cf07a25ed7c2b3bdb035ea073047f5ba5c89f08c645145f71a7d5bb62"
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
