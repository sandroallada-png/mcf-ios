import UIKit
import Capacitor
import FirebaseCore

// ─────────────────────────────────────────────────────────────────────────────
// MCF iOS — AppDelegate.swift
// Gère l'initialisation de Firebase, les URLs (Google Sign-In),
// les notifications push (APNs), et les Universal Links.
// ─────────────────────────────────────────────────────────────────────────────

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ── Lancement de l'application ────────────────────────────────────────────
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Initialisation de Firebase (doit être fait avant tout le reste)
        FirebaseApp.configure()

        // Demande d'autorisation pour les notifications push
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()

        return true
    }

    // ── URL Schemes (Google Sign-In, Firebase) ────────────────────────────────
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Laisser Capacitor gérer les URL schemes (Google OAuth redirect, etc.)
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    // ── Universal Links ───────────────────────────────────────────────────────
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return ApplicationDelegateProxy.shared.application(
            application,
            continue: userActivity,
            restorationHandler: restorationHandler
        )
    }

    // ── Enregistrement APNs réussi — transmettre le token à Capacitor ────────
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        NotificationCenter.default.post(
            name: .capacitorDidRegisterForRemoteNotifications,
            object: deviceToken
        )
    }

    // ── Enregistrement APNs échoué ────────────────────────────────────────────
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        NotificationCenter.default.post(
            name: .capacitorDidFailToRegisterForRemoteNotifications,
            object: error
        )
    }

    // ── Cycle de vie ──────────────────────────────────────────────────────────
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
}

// ─────────────────────────────────────────────────────────────────────────────
// Extension : gestion des notifications en avant-plan
// ─────────────────────────────────────────────────────────────────────────────
extension AppDelegate: UNUserNotificationCenterDelegate {

    /// Affiche la notification même si l'app est au premier plan
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
    }

    /// Réponse de l'utilisateur sur une notification (tap, action)
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}
