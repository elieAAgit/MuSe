//
//  CoreDataStack.swift
//  MuSe
//
//  Created by Elie Arquier on 23/04/2022.
//

import Foundation
import CoreData

final class CoreDataStack {

    // MARK: - Property
    let name: String

    // MARK: - Initializer
    init(name: String) {
        self.name = name
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: name)
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.type = NSSQLiteStoreType

        // Register the transformer
        CategoryValueTransformer.register()

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Save Context
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
