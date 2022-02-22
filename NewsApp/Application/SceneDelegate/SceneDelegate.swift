//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Tatiana Kornilova on 17/12/2019.
//  Copyright © 2019 Tatiana Kornilova. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder {

    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Create the SwiftUI view that provides the window contents.
        // let contentView = ContentViewArticles()
        let contentView = TabedView()
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }

}
