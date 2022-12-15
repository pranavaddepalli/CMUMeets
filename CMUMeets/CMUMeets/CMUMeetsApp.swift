//
//  CMUMeetsApp.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("CMUMeets is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    return true
  }
}

@main
struct CMUMeetsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            let defaults = UserDefaults.standard

            if let username = defaults.string(forKey: "username"), let name = defaults.string(forKey: "name") {
                MainPageView(firebase: Firebase())
            } else {
                LoginView(firebase: Firebase())
            }

        }
    }
}
