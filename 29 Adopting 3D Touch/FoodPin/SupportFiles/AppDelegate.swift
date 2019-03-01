//
//  AppDelegate.swift
//  FoodPin
//
//  Created by Rami on 12/1/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    enum QuickAction: String {
        case OpenFavorites = "OpenFavorites"
        case OpenDiscover = "OpenDiscover"
        case NewRestaurant = "NewRestaurant"
        
        init?(fullIdentifier: String) {
            guard let shortcutIdentifier = fullIdentifier.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: shortcutIdentifier)
        }
    }
    
    func application(
        _ application: UIApplication, 
        performActionFor shortcutItem: UIApplicationShortcutItem, 
        completionHandler: @escaping (Bool) 
        -> Void) {
        completionHandler(handleQuickAction(shortcutItem: shortcutItem))
    }
    
    private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) 
        -> Bool {
            let shortcutType = shortcutItem.type
            guard let shortcutIdentifier = QuickAction(fullIdentifier: shortcutType) else {
                return false
            }
            guard let tabBarController = window?.rootViewController as? UITabBarController else {
                return false
            }
            switch shortcutIdentifier {
            case .OpenFavorites:
                tabBarController.selectedIndex = 0
            case .OpenDiscover: 
                tabBarController.selectedIndex = 1
            case .NewRestaurant:
                if let navController = tabBarController.viewControllers?[0] {
                    let restaurantTableViewController = navController.children[0]
                    restaurantTableViewController.performSegue(
                        withIdentifier: "addRestaurant", 
                        sender: restaurantTableViewController)
                } else {
                    return false
                }
            }
            return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            // Override point for customization after application launch.

            // change the back button for entire app (add space in storyboard for FoodPin scene to remove text)
            let backButtonImage = UIImage(named: "back")
            UINavigationBar.appearance().backIndicatorImage = backButtonImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage

            // customize the tab bar
            UITabBar.appearance().tintColor = UIColor(red: 231, green: 76, blue: 60)
            UITabBar.appearance().barTintColor = UIColor.black

            // if wanting to change the statusbar style across the entire app
            // must also change in info.plist
            //    UIApplication.shared.statusBarStyle = .lightContent
            return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FoodPin")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                        // swiftlint:disable:next line_length
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store isn't accessible, due to permissions / data protection when the device is locked
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                        // swiftlint:disable:next line_length
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // swiftlint:disable:next line_length
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // swiftlint:disable:next line_length
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // swiftlint:disable:next line_length
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // swiftlint:disable:next line_length
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // swiftlint:disable:next line_length
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // swiftlint:disable:next line_length
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // swiftlint:disable:next line_length
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
