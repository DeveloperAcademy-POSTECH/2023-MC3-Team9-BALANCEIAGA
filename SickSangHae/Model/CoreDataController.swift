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

extension NSManagedObjectContext {
    func get(by objectID: NSManagedObjectID) -> Receipt? {
        do {
            guard let result = try self.existingObject(with: objectID) as? Receipt else {
                print("Get 한 object 변환 실패")
                return nil
            }
            return result
        } catch {
            print("해당하는 object 찾는거 실패")
            return nil
        }
    }
    
    func delete(by objectId: NSManagedObjectID) {
        guard let target = get(by: objectId) else { return }
        self.delete(target)
    }
}
