//
//  SCCoreDataManager.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/21/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit
import CoreData

class SCCoreDataManager: NSObject {
    
    static let shared = SCCoreDataManager()
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "StrokeCalc", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("StrokeCalc.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
//            abort()
        }
        
        return coordinator
    }()
    
    lazy var parentContext : NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    
    lazy var defaultContext : NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType:.mainQueueConcurrencyType)
        context.parent =  self.parentContext
        return context
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        OperationQueue.main.addOperation {
            do {
                try self.defaultContext.obtainPermanentIDs(for: Array(self.defaultContext.insertedObjects))
            } catch {
                let nserror = error as NSError
                NSLog("\nCoreData : Failed to obtain permanentIDs in default context\(nserror), \(nserror.userInfo)")
            }
            
            if self.defaultContext.hasChanges {
                do {
                    try self.defaultContext.save()
                } catch {
                    
                    let nserror = error as NSError
                    NSLog("\nCore Data : Failed to save main context \(nserror), \(nserror.userInfo)")
                    //                abort()
                }
            }
        }
    }
    
    func saveParentContext() {
        saveContext()
        parentContext.perform { 
            if self.parentContext.hasChanges {
                do {
                    try self.parentContext.save()
                } catch {
                    let nserror = error as NSError
                    NSLog("\nCoreData : Failed to save parent context\(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
