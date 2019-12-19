// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Messenger-api",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // 🔵 Swift ORM (queries, models, relations, etc) built on postgresql.
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0")

    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "FluentPostgreSQL"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)

