// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CreateGameSession",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", .upToNextMajor(from: "0.5.2")),
        .package(url: "https://github.com/awslabs/aws-sdk-swift", .upToNextMajor(from: "0.2.3")),
        .package(url: "https://github.com/maniramezan/Grallistrix", branch: "main"),
        .package(url: "https://github.com/apple/swift-async-algorithms", .upToNextMajor(from: "0.0.1")),
    ],
    targets: [
        .executableTarget(
            name: "CreateGameSession",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),
                .product(name: "Grallistrix", package: "Grallistrix"),
                .target(name: "GraphQLClient"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
            ]),
        .target(
            name: "GraphQLClient",
            dependencies: [
                .product(name: "Grallistrix", package: "Grallistrix"),
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]),
        .testTarget(
            name: "CreateGameSessionTests",
            dependencies: ["CreateGameSession"]),
    ]
)
