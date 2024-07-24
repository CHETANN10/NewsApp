//
//  PersistentStorage.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation
import CoreData

class PersistentStorage {
    static let shared = PersistentStorage()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "NewsPersistentData")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }    
}
