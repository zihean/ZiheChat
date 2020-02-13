//
//  AppDelegate.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit
import CoreData
import LeanCloud
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Bmob.register(withAppKey:"472985cefbb3b2e48096f7e4d513fe19")
        do{
            try LCApplication.default.set(
                id:"jqYxk2GwSRWWVxaK5aPpf46v-gzGzoHsz",
                key:"TWHJDDczvNjlJ7NSEY9hz4de")
            //serverURL:"https://jqyxk2gw.lc-cn-n1-shared.com"
        }catch{
            print(error)
        }
        LCApplication.logLevel = .all
        LCApplication.logLevel = .off
        //save()
        
        //testLC()
//        print("########################")
//        LCEngine.run("test", parameters: ["content":"caonima"]){result in
//            switch result{
//            case .success(value: let resultValue):
//                print(resultValue)
//                break
//            case .failure(error: let error):
//                print(error)
//                break
//            }
//        }
//        print("#################%%%%%%%%%%")
        return true
    }
    
    func save(){
        let gamescore:BmobObject=BmobObject(className: "GameScore")
        gamescore.setObject("安子和", forKey: "playerName")
        gamescore.setObject(100, forKey: "score")
        gamescore.saveInBackground(){(isSuccessful,error) in
            if error != nil{
                print("Error::::::\(error)")
            }else{
                print("存储成功！")
            }
        }
    }
    
    func testLC(){
        do{
            let testObjc = LCObject(className:"Test")
            try testObjc.set("name",value:"azh")
            let result = testObjc.save(){result in
                switch result{
                    case .success:
                        break
                    case .failure(error: let error):
                        print(error)
                }
            }
        }catch{
            print(error)
        }
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ZiheChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
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

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

