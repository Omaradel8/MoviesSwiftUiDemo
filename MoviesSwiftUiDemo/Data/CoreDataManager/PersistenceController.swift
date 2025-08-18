//
//  PersistenceController.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 18/08/2025.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Movies")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}
