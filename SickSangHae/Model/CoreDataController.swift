//
//  CoreDataController.swift
//  SickSangHae
//
//  Created by user on 2023/07/13.
//

import CoreData
import Foundation

struct CoreDataController {
    static let shared = CoreDataController()
    let container = NSPersistentContainer(name: "SickSangHaeModel")
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("코어데이터 로딩 실패")
                print(error.localizedDescription)
            }
        }
    }
}
