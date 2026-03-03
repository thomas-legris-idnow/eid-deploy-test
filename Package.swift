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
        )
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
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/2.1.0/IDnowEID.xcframework.zip",
            checksum: "3bb7a2b30cf70a5acd108248cc3398c51b7e2a6fb941d56e2c19d15a18b76fdf"
        ),
        .binaryTarget(
            name: "IDnowEIDDynamic",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/2.1.0/IDnowEIDDynamic.xcframework.zip",
            checksum: "af18041145a813056be5cfb9dca135e1b5a71fabdba0cb3c0b46d09cc35b6849"
        ),
        .binaryTarget(
            name: "IDnowEIDGovernikus",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download/2.1.0/IDnowEIDGovernikus.xcframework.zip",
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
        ).target(
            name: "IDnowEIDGovernikusWrapper",
            dependencies: [
                "IDnowEIDGovernikus",
                .product(name: "OpenSSL", package: "OpenSSL"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios"),
                .product(name: "AusweisApp2", package: "AusweisApp2")
            ],
            path: "sources-governikus"
        )
    ]
)
