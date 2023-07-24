//
//  ReceiptViewModel.swift
//  SickSangHae
//
//  Created by user on 2023/07/15.
//

import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
    private let viewContext = PersistentController.shared.viewContext
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
    
    var eatenList: [Receipt] {
        return receipts
            .filter{ $0.currentStatus == .Eaten }
            .sorted{ $0.dateOfHistory < $1.dateOfHistory }
    }
    
    var spoiledList: [Receipt] {
        return receipts
            .filter{ $0.currentStatus == .Spoiled }
            .sorted{ $0.dateOfHistory < $1.dateOfHistory }
    }
    
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
        receipt.icon = "icon_test"
        receipt.price = price
        receipt.previousStatus = .shortTermUnEaten
        receipt.currentStatus = .shortTermUnEaten
        receipt.itemCategory = .Unknown
        
        saveChanges()
        self.getAllReceiptData()
    }
    
    func createTestReceiptData() {
        
        let receipt = Receipt(context: viewContext)
        receipt.id = UUID()
        receipt.name = "TestName \(receipts.count)"
        receipt.dateOfPurchase = Date.now
        receipt.dateOfHistory = Date.distantPast
        receipt.icon = "icon_test"
        receipt.price = 6000.0
        receipt.previousStatus = .shortTermUnEaten
        receipt.currentStatus = .shortTermUnEaten
        receipt.itemCategory = .Unknown
        
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
            updateStatusToUnEaten(target: target, to: status)
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
        guard let receipt = viewContext.get(by: target.objectID) else { return }
        guard receipt.currentStatus == .Eaten || receipt.currentStatus == .Spoiled else { return }
        
        receipt.currentStatus = receipt.previousStatus
        receipt.dateOfHistory = receipt.dateOfPurchase
        
        saveChanges()
        getAllReceiptData()
    }
}


