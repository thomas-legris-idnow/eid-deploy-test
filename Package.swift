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
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.0.0/IDnowEID.xcframework.zip",
            checksum: "28060b14db576ffdae6fd8ed577e7a6c6dbb5ed9ef520c4679479515a4eb2f41"
        ),
        .binaryTarget(
            name: "IDnowEIDDynamic",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.0.0/IDnowEIDDynamic.xcframework.zip",
            checksum: "eb0b42bde623cb62f1576c18aef17db086d795732797510e1c6aa998d28247e8"
        ),
        .binaryTarget(
            name: "IDnowEIDGovernikus",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/3.0.0/IDnowEIDGovernikus.xcframework.zip",
            checksum: "7975a3231edb64bc9619356edd2f4cb03767cb59d9016ba815120df86f785be5"
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
