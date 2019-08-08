//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
//    /// Entries is a computed property. It's getting its values from the results of a NSFetchRequest. The <Model> defines the generic type. This ensures that our entries array can only hold Entry Objects.
//    var entries: [Entry] {
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }
    
    // local NSFRC
    var fetchResultsController: NSFetchedResultsController<Entry>
    // NSFRC:
    
    init() {
        // Define fetchrequest
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest() //Entities have their own fetch requests, so as long as you have a coredata generated Model/Entrity it'll have it
        
        // Allows us to sort fetch requests by timestamp in descending order. Can put sorts in array of our Entity attributes
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        // initialize a results controller
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        // Asign resultsController NSFRC to local variable. Assign a value to the local variable above so we can access it outside of this class
        fetchResultsController = resultsController
        
        // This initiates the fetch. Last step to start the fetch.
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch! \(#function) \(error.localizedDescription)")
        }
        
    }
    
    ///CRUD
    /// We define a createEntry method that takes in two strings: Title, and body.
    func createEntry(withTitle: String, withBody: String) {
        //Then we are using the convenience init we extended the Entry Class with and pass in those strings. This creates our Entry Objects with all required data.
        let _ = Entry(title: withTitle, body: withBody)
        
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    /// Remove from persistent storage, then saving when we're done.
    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    /// Attempting to save all our Entry Data to our CoreDataStacks Persisten Store
    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}
