//
//  AppDelegate.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/09.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    var noticeListCell = NoticeListViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        //自動ログイン
        if Auth.auth().currentUser != nil { //もしもユーザがログインしていたら
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateInitialViewController()
            
            self.window?.rootViewController = initialViewController
            
            self.window?.makeKeyAndVisible()
        }
        
        // 通知許可申請
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                
                if granted {
                    print("通知許可")
                    
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self
                    
                } else {
                    print("通知拒否")
                }
            })
            
        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        //Realmのマイグレーション処理
        let config = Realm.Configuration(
            schemaVersion : 5 , //データの構造が変わったらここを変える
            migrationBlock : { migration, oldSchemaVersion in
                if oldSchemaVersion < 5 {
                    var nextID = 0
                    migration.enumerateObjects(ofType: Profile.className()) { oldObject, newObject in
                        newObject!["id"] = String(nextID)
                        nextID += 1
                    }
                    migration.enumerateObjects(ofType: Notification.className()) { oldObject, newObject in
                        newObject!["id"] = String(nextID)
                        nextID += 1
                    }
                }
        }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
    
    // Push通知受信時とPush通知をタッチして起動したときに呼ばれる
    private func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        switch application.applicationState {
        case .inactive:
            // アプリがバックグラウンドにいる状態で、Push通知から起動したとき
            break
        case .active:
            // アプリ起動時にPush通知を受信したとき
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.noticeListCell.addCell()
            break
        case .background:
            // アプリがバックグラウンドにいる状態でPush通知を受信したとき
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.noticeListCell.addCell()
            break
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

