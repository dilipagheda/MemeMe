//
//  AppDelegate.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 28/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var memes = [Meme]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let testmeme = Meme(topText: "test top", bottomText: "test bottom", memedImage: UIImage(named: "testimage")!, originalImage: UIImage(named: "testimage")!)
//        let testmeme2 = Meme(topText: "hello top", bottomText: "hello bottom", memedImage: UIImage(named: "testimage2")!, originalImage: UIImage(named: "testimage2")!)
//
//        memes.append(testmeme)
//        memes.append(testmeme2)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

