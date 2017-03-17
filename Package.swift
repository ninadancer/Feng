import PackageDescription

let package = Package(
    name: "Feng",
    targets: [
        Target(name: "FengKit", dependencies: []),
        Target(name: "Feng", dependencies: ["FengKit"])
    ],
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine", "3.0.0-pre1"),
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2),
        .Package(url: "https://github.com/kylef/PathKit", majorVersion: 0, minor: 8)
    ],
    exclude: ["Tests/Fixtures"]
)
