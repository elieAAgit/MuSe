//
//  MockCoreDataStack.swift
//  MuSeTests
//
//  Created by Elie Arquier on 23/11/2023.
//

import Foundation
import CoreData
@testable import MuSe

// Using of NSInMemoryStoreType instead of NSSQLiteStoreType

final class MockCoreDataStack {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {

        let container = NSPersistentCloudKitContainer(name: name)
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.type = NSInMemoryStoreType
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

}

