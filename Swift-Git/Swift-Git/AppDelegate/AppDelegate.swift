//
//  AppDelegate.swift
//  Swift-Git
//
//  Created by Rafael Silva on 27/05/20.
//  Copyright © 2020 Rafael Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let factory = ModuleFactoryImp()
        self.window?.rootViewController = factory.makeRepositoriesOutput()
        self.window?.makeKeyAndVisible()
        return true
    }
}

