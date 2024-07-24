//
//  CoredataManager.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation
import CoreData

class CoredataManager {
    
    let persistenceStorage = PersistentStorage.shared
    
    // MARK: - Saving news record to coredata
    
    func saveNewsData(news: [NewsModel]) {
        let context = persistenceStorage.container.viewContext
        
        for item in news {
            let newItem = News(context: context)
            newItem.headline = item.headLine
            newItem.imageUrl = item.imageUrl
            newItem.pubdate = item.date
            newItem.newsdescription = item.description
        }
        
        self.persistenceStorage.saveContext()
    }
    
    // MARK: - Fetching news records from coredata
    func fetchItemsFromCoreData() async throws -> [NewsModel] {
        let context = persistenceStorage.container.viewContext
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            let fetchedItems = try context.fetch(fetchRequest)
            let responseItems: [NewsModel] = fetchedItems.map {
                NewsModel(headLine: $0.headline, description: $0.newsdescription, imageUrl: $0.imageUrl, date: $0.pubdate)
            }
            return responseItems
        } catch {
            print("Error while fetching all records: \(error)")
        }
        return []
    }
    
    // MARK: - Deleting news records from coredata

    func deleteAllRecords() {
        let context = persistenceStorage.container.viewContext

        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        fetchRequest.includesPropertyValues = false

        do {
            let fetchResults = try context.fetch(fetchRequest)
            for object in fetchResults {
                context.delete(object)
            }
            try context.save()
        } catch let error as NSError {
            print("Error deleting all records: \(error)")
        }
    }
}
