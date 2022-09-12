//
//  Persistence.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-07-10.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            _ = Item(name: "name", context: viewContext)
            _ = Patient(familyName: "Swift", name: "Taylor", swedishSocialSecurityNumber: "98", context: viewContext) // PatientEntity.
            _ = Journal(date: Date.now, text: "Example for journal-entry", context: viewContext) // Journal-entryEntity.
            _ = Law(date: Date.now, name: "ExampleLaw", paragraph: "§ 19a", context: viewContext) // LawEntity.
            _ = Reading(amount: 0.0, date: Date.now, unit: "IU", context: viewContext) // ReadingEntity.
            _ = Medicine(date: Date.now, name: "ExampleMedicine", context: viewContext) // MedicineEntity.
            _ = MedicalTask(date: Date.now, name: "ExampleMedicalTask", context: viewContext) // MedicalTaskEntity.
            // If you have different entities, you should enter them here to have some data to preview in the preview canvas.
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    /// Creates an empty container to run "UnitTests" on.
    static var empty: PersistenceController = {
        PersistenceController(inMemory: true)
    }()


    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CareNote")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
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
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Function that saves changes in the viewContext and kan be called by other functions - to shorten the lines of text.
    func save() {
        let viewContext = container.viewContext
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
// MARK: - Information function was called
        print("""
              Message from PersistenceController:
              * "func save()" has been called: - PersistenceController.save -> viewContext.save() = THE viewContext has been saved. *
              """)
    }
}
