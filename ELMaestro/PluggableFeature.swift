//
//  PluggableFeature.swift
//  ELMaestro
//
//  Created by Angelo Di Paolo on 5/19/16.
//  Copyright © 2016 WalmartLabs. All rights reserved.
//

import Foundation
import UIKit

@objc
public protocol PluggableFeature: Pluggable {
    /**
     API factory method for a module's API it exports. You will likely want to
     typecast this, ie:
     
     let pluginAPI = supervisor.pluginAPI(forIdentifier: "com.myorg.mymodule") as? MyPluginAPI
     */
    @objc optional func pluginAPI() -> AnyObject?
    
    /**
     After all plugins have been started, the system will dispatch this to your plugin.
     */
    @objc optional func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    
    /**
     Application lifecycle events
     */
    func applicationWillTerminate()
    func applicationDidReceiveMemoryWarning()
    
    @objc optional func applicationWillResignActive()
    @objc optional func applicationDidEnterBackground()
    @objc optional func applicationWillEnterForeground()
    @objc optional func applicationDidBecomeActive()
    
    /**
     Local and Remote Notification events
     */
    @objc optional func application(_ application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings)
    @objc optional func application(_ application: UIApplication, didReceiveLocalNotification notification: UILocalNotification)
    @objc optional func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: @escaping () -> Void)
    @objc optional func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    @objc optional func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
    @objc optional func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    @objc optional func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void)
    
    @objc @available(iOS 9.0, *)
    optional func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void)
    
    @objc @available(iOS 9.0, *)
    optional func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void)
    
    // Continuity
    
    @objc optional func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    
    /**
     Application events for background event handling
     */
    @objc optional func applicationHandleEventsForBackgroundURLSession(_ identifier: String, completionHandler: () -> Void)
    
    /**
     Application events for watchkit handling -- is this needed?
     */
    @objc optional func applicationHandleWatchKitExtensionRequest(_ userInfo: [AnyHashable: Any]?, reply: (([AnyHashable: Any]?) -> Void)!)
    
    @objc @available(iOS 9.0, *)
    /**
     Application events for handling force touch springboard shortcuts
     
     - parameter shortcutItem:      The shortcut shortcut item
     - parameter completionHandler: The completion handler, fired after the shortcut has been handled
     
     - returns: Whether the action was performed by the plugin
     */
    optional func applicationPerformActionForShortcutItem(_ shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) -> Bool
}
