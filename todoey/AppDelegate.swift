//
//  AppDelegate.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 3/12/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
            return true
    }
    }


