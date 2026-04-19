// swift-tools-version: 5.9
import PackageDescription

// ─────────────────────────────────────────────────────────────────────────────
// MCF iOS — Package.swift
// PROJET ISOLÉ : toutes les dépendances viennent de GitHub (SPM remote).
// Ce fichier ne dépend d'AUCUN node_modules externe.
// ─────────────────────────────────────────────────────────────────────────────

let package = Package(
    name: "CapApp-SPM",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CapApp-SPM",
            targets: ["CapApp-SPM"]
        )
    ],
    dependencies: [
        // ── Capacitor Core (iOS Swift runtime) ───────────────────────────────
        .package(
            url: "https://github.com/ionic-team/capacitor-swift-pm.git",
            exact: "8.1.0"
        ),

        // ── Plugins officiels Capacitor (App, Camera, PushNotifications) ─────
        .package(
            url: "https://github.com/ionic-team/capacitor-plugins.git",
            exact: "8.1.0"
        ),

        // ── @capacitor-firebase/authentication — Firebase Auth ──────────────
        .package(
            url: "https://github.com/capawesome-team/capacitor-firebase.git",
            from: "7.0.0"
        ),
    ],
    targets: [
        .target(
            name: "CapApp-SPM",
            dependencies: [
                // Core Capacitor
                .product(name: "Capacitor",  package: "capacitor-swift-pm"),
                .product(name: "Cordova",    package: "capacitor-swift-pm"),

                // Plugins officiels (monorepo capacitor-plugins sur GitHub)
                .product(name: "CapacitorApp",               package: "capacitor-plugins"),
                .product(name: "CapacitorCamera",            package: "capacitor-plugins"),
                .product(name: "CapacitorPushNotifications", package: "capacitor-plugins"),

                // Firebase Authentication (capawesome-team sur GitHub)
                .product(name: "CapacitorFirebaseAuthentication", package: "capacitor-firebase"),
            ],
            path: "Sources"
        )
    ]
)
