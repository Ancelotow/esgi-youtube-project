//
//  AppDelegate.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 27/01/2022.
//

import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        // Initialize Google sign-in.
        GIDSignIn.sharedInstance().clientID = "172071375553-6dh1d6jnrtdh0thhdpjv3evrs4tit3en.apps.googleusercontent.com"
    }

    func application(_ application: UIApplication,
        open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                   sourceApplication: sourceApplication,
                                                   annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: ConnectionViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }


}

