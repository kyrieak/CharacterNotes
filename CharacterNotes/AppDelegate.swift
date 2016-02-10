//
//  AppDelegate.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/18/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var documentContext: NSManagedObjectContext?

  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    if (documentContext == nil) {
      documentContext = getDocumentContext()
      return false
    } else {
      return true
    }
//    let document = getUIManagedDocument()
//    NSLog("\(document)")
//    
//    if (document.documentState == .Normal) {
//      self.documentContext = document.managedObjectContext
//      NSLog("\(document)")
//
//      return true
//    } else {
//      return false
//    }
    // Override point for customization after application launch.
  }
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    Log.withSpace("url path: \(url.path)")
    
    return (url.scheme == "cnotes")
  }
  
  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    Log.withSpace("url path: \(url.path)")
    return (url.scheme == "cnotes")
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  private func getUIManagedDocument() -> UIManagedDocument {
    let fileManager = NSFileManager.defaultManager()
    let documentsDir = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    let dataDocURL = documentsDir!.URLByAppendingPathComponent("CNDataDoc")
    let document = UIManagedDocument(fileURL: dataDocURL)
    
    if (!fileManager.fileExistsAtPath(dataDocURL.path!)) {
      NSLog("Document Did Not Exist, creating now")

      document.saveToURL(dataDocURL, forSaveOperation: .ForCreating, completionHandler: {(success: Bool) in
        if (!success) {
          NSLog("create document at path \(dataDocURL.path) failed")
        }
      })
    } else {
      NSLog("Document Did Exist attempting to delete")
      
      do {
        try fileManager.removeItemAtPath(dataDocURL.path!)
        return getUIManagedDocument()
      } catch {
        NSLog("failed to delete ui doc")
        return document
      }
      
//      document.openWithCompletionHandler({(success: Bool) in
//        if (!success) {
//          NSLog("open document at path \(dataDocURL.path) failed")
//        }
//      })
    }
    NSLog("\(document)")
    return document
  }
  
  func getDocumentContext() -> NSManagedObjectContext {
    if (documentContext == nil) {
      documentContext = getUIManagedDocument().managedObjectContext
    }
    
    return documentContext!
  }
}

