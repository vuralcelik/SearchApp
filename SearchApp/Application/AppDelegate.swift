//
//  AppDelegate.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: - Properties
    var window: UIWindow?

    //MARK: - UIApplication Delegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //MARK: Initial Page Setup
        setupInitialPage()
        
        return true
    }
    
    //MARK: - Helper Methods
    private func setupInitialPage() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = BaseNavigationController(rootViewController: SearchVC())
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}

