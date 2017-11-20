//
//  AppDelegate.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        registerDefaultsFromSettingsBundle()
    }
    
    func registerDefaultsFromSettingsBundle() {
        let userDefaults = UserDefaults.standard
        let url = userDefaults.string(forKey: "server-url")
        if url == nil {
            if let settingsURL = Bundle.main.url(forResource: "Root", withExtension: "plist", subdirectory: "Settings.bundle"),
                let settings = NSDictionary(contentsOf: settingsURL),
                let preferences = settings["PreferenceSpecifiers"] as? [NSDictionary] {
                
                var defaultsToRegister = [String: AnyObject]()
                for prefSpecification in preferences {
                    if let key = prefSpecification["Key"] as? String,
                        let value = prefSpecification["DefaultValue"] {
                        defaultsToRegister[key] = value as AnyObject?
                    }
                }
                
                userDefaults.register(defaults: defaultsToRegister);
            }
        }
    }

}

