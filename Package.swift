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
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", exact: "3.6.1"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.3")
    ],
    targets: [
        .binaryTarget(
            name: "IDnowEID",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download//IDnowEID.xcframework.zip",
            checksum: "aa0b9b604016c29c6c3cc70e78348a63a40919f3f8bf0330405f794b83948b5b"
        ),
        .binaryTarget(
            name: "IDnowEIDDynamic",
            url: "https://github.com/thomas-legris-idnow/eid-deploy-test/releases/download//IDnowEIDDynamic.xcframework.zip",
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
        )
    ]
)
