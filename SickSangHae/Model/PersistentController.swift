//
//  CoreDataController.swift
//  SickSangHae
//
//  Created by user on 2023/07/13.
//

import CoreData
import Foundation
import CloudKit

struct PersistentController {
    static let shared = PersistentController()
    let container = NSPersistentContainer(name: "SickSangHaeModel")
    
    private let containerIdentifier = "SickSangHaeContainer"
    private let recordType = "SickSangHaeType"
    private let cloudKitZoneID = CKRecordZone.ID(zoneName: "SickSangHaeModel")
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container.loadPersistentStores { [self] description, error in // 클로저가 self를 변경하는 메서드나 속성을 참조해서 암시적으로 캡쳐하는 것을 피하기 위해 사용
            if let error {
                print("코어데이터 로딩 실패")
                print(error.localizedDescription)
            } else {
                self.syncDataToCloudKit() // 앱 실행 시 CloudKit로 데이터 업로드
                self.syncDataFromCloudKit() // 앱 실행 시 CloudKit에서 데이터 가져와 CoreData에 저장
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
    
    func delete(by object: Receipt) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Receipt")
        request.predicate = NSPredicate(format: "id == %@", object.id.uuidString)
        do {
            let results = (try fetch(request) as? [NSManagedObject]) ?? [NSManagedObject]()
            results.forEach {
                self.delete($0)
            }
        } catch {
            print("CoreData 에서 삭제 실패함!!!\n")
        }
        
        self.saveContext()
    }
    
    func saveContext() {
        do {
            if self.hasChanges {
                try save()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension PersistentController {
    // CloudKit 관련 상수 및 변수
    // CloudKit 데이터베이스에 변경 사항 반영
    func syncDataToCloudKit() {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        do {
            let receipts = try context.fetch(fetchRequest)
            
            // syncDataToCloudKit 함수 내에서 Receipt 엔터티의 속성 활용하여 CloudKit에 데이터 저장
            for receipt in receipts {
                let record = CKRecord(recordType: recordType)
                record["category"] = receipt.category as CKRecordValue
                record["currentState"] = receipt.currentState as CKRecordValue
                record["dateOfHistory"] = receipt.dateOfHistory as CKRecordValue
                record["dateOfPurchase"] = receipt.dateOfPurchase as CKRecordValue
                record["icon"] = receipt.icon as CKRecordValue
                if let receiptID = receipt.id as? CKRecordValue {
                    record["id"] = receiptID
                }
                record["name"] = receipt.name as CKRecordValue
                if let placeOfPurchase = receipt.placeOfPurchase as? CKRecordValue {
                    record["placeOfPurchase"] = placeOfPurchase
                }
                record["previousState"] = receipt.previousState as CKRecordValue
                record["price"] = receipt.price as CKRecordValue
                
                let container = CKContainer(identifier: containerIdentifier)
                let cloudKitDatabase = container.privateCloudDatabase // privateCloudDatabase를 이용하여 database 가져오기
                
                cloudKitDatabase.save(record) { (record, error) in
                    if let error = error {
                        print("CloudKit에 데이터를 저장하는 중 에러 발생: \(error.localizedDescription)")
                    } else {
                        print("CloudKit에 데이터 저장 완료")
                    }
                }
            }
            
        } catch {
            print("CoreData에서 Receipt를 가져오는 중 에러 발생: \(error.localizedDescription)")
        }
    }
    
    // CloudKit에서 데이터 불러와 CoreData에 저장
    func syncDataFromCloudKit() {
        let context = container.viewContext
        let cloudKitDatabase = CKContainer(identifier: containerIdentifier).privateCloudDatabase
        
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = CKQueryOperation.maximumResults
        
        operation.recordFetchedBlock = { record in
            let receipt = Receipt(context: context)
            receipt.category = record["category"] as? Int16 ?? 0
            receipt.currentState = record["currentState"] as? Int16 ?? 0
            if let dateOfHistory = record["dateOfHistory"] as? Date {
                receipt.dateOfHistory = dateOfHistory
            }
            if let dateOfPurchase = record["dateOfPurchase"] as? Date {
                receipt.dateOfPurchase = dateOfPurchase
            }
            receipt.icon = record["icon"] as? String ?? ""
            receipt.id = record["id"] as? UUID ?? UUID()
            receipt.name = record["name"] as? String ?? ""
            receipt.placeOfPurchase = record["placeOfPurchase"] as? String ?? ""
            receipt.previousState = record["previousState"] as? Int16 ?? 0
            receipt.price = record["price"] as? Double ?? 0.0
            
            do {
                try context.save()
            } catch {
                print("CoreData에 저장하는 중 에러 발생: \(error.localizedDescription)")
            }
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            if let error = error {
                print("CloudKit에서 데이터를 가져오는 중 에러 발생: \(error.localizedDescription)")
            } else {
                print("CloudKit에서 데이터 가져오기 완료")
            }
        }
        
        cloudKitDatabase.add(operation)
    }

}
