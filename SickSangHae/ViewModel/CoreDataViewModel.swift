//
//  ReceiptViewModel.swift
//  SickSangHae
//
//  Created by user on 2023/07/15.
//

import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
    let viewContext = PersistentController.shared.viewContext
    @Published var receipts: [Receipt] = []
    
    var shortTermUnEatenList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .shortTermUnEaten}
    }
    
    var shortTermPinnedList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .shortTermPinned}
    }
    
    var longTermUnEatenList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .longTermUnEaten}
    }
    
    var historyDictionary: [String : [Receipt]] {
        let eatenList: [Receipt] = receipts.filter { $0.currentStatus == .Eaten || $0.currentStatus == .Spoiled }
        var dateGroupDictionary: [String : [Receipt]] = [String : [Receipt]]()
        
        
        eatenList.forEach { item in
            let updatedDate = item.dateOfPurchase.formattedDate
            if let _ = dateGroupDictionary[updatedDate] {
                dateGroupDictionary[updatedDate]!.append(item)
            } else {
                dateGroupDictionary[updatedDate] = [item]
            }
        }
        return dateGroupDictionary
    }
    
//  MARK: 먹은것과 상한것 구분을 안한다고 해서 일단은 주석처리 해놨음
//    var spoiledList: [Receipt] {
//        return receipts
//            .filter{ $0.currentStatus == .Spoiled }
//            .sorted{ $0.dateOfHistory > $1.dateOfHistory }
//    }
    
    init() {
        getAllReceiptData()
    }
    
    
}

extension CoreDataViewModel {
    private func getAllReceiptData() {
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateOfPurchase", ascending: false),
            NSSortDescriptor(key: "name", ascending: true)]
        do {
            receipts = try viewContext.fetch(request)
        } catch {
            print("Cannot fetch receipts from SickSangHae Model")
        }
    }
    
    private func saveChanges() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            print("Error while Saving in CoreData")
        }
    }
    
    func createReceiptData(name: String, price: Double) {
        
        let receipt = Receipt(context: viewContext)
        receipt.id = UUID()
        receipt.name = name
        receipt.dateOfPurchase = Date.now
        receipt.dateOfHistory = Date.now
        receipt.icon = "shoppingCart"
        receipt.price = price
        receipt.previousStatus = .shortTermUnEaten
        receipt.currentStatus = .shortTermUnEaten
        receipt.itemCategory = .unknown
        
        saveChanges()
        self.getAllReceiptData()
    }
    
    func createTestReceiptData(status: Status) {

            let receipt = Receipt(context: viewContext)
            receipt.id = UUID()
            receipt.name = "TestName \(receipts.count)"
            receipt.dateOfPurchase = Date.now
            receipt.dateOfHistory = Date.distantPast
            receipt.icon = "shoppingCart"
            receipt.price = 6000.0
            receipt.previousStatus = status
            receipt.currentStatus = status
            receipt.itemCategory = .unknown
            
            saveChanges()
            self.getAllReceiptData()

    }
    
    func deleteReceiptData(target: Receipt) {
        viewContext.delete(by: target)
        getAllReceiptData()
    }
    
    func updateStatus(target: Receipt, to status: Status) {
        guard let receipt = viewContext.get(by: target.objectID) else { return }

        switch status {
        case .shortTermUnEaten, .shortTermPinned, .longTermUnEaten:
            receipt.currentStatus = status
        case .Eaten:
            guard receipt.currentStatus != .Eaten else { break }

            if receipt.currentStatus != .Spoiled {
                receipt.previousStatus = receipt.currentStatus
            }

            receipt.currentStatus = .Eaten

        case .Spoiled:
            guard receipt.currentStatus != .Spoiled else { break }

            if receipt.currentStatus != .Eaten {
                receipt.previousStatus = receipt.currentStatus
            }


            receipt.currentStatus = .Spoiled
        }

        receipt.dateOfHistory = Date.now

        saveChanges()
        getAllReceiptData()
    }
    
    
    func recoverPreviousStatus(target: Receipt) {
        guard let receipt = viewContext.get(by: target.objectID), receipt.currentStatus == .Eaten || receipt.currentStatus == .Spoiled else { return }
        
        receipt.currentStatus = receipt.previousStatus
        receipt.dateOfHistory = receipt.dateOfPurchase
        
        saveChanges()
        getAllReceiptData()
    }
    
    func editReceiptData(target: Receipt, icon: String, name: String, dateOfPurchase: Date, price: String) {
        guard let receipt = viewContext.get(by: target.objectID) else { return }
        
        receipt.icon = icon
        receipt.name = name
        receipt.dateOfPurchase = dateOfPurchase
        receipt.price = Double(price) ?? 0.0
        
        saveChanges()
        getAllReceiptData()
    }
}


