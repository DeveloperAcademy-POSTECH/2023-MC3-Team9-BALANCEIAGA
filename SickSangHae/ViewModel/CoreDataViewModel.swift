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
    
    var unConsumedList: [Receipt] {
        return receipts.filter{ $0.status == .UnConsumed }
    }
    
    var eatenList: [Receipt] {
        return receipts.filter{ $0.status == .Eaten }
    }
    
    var rottenList: [Receipt] {
        return receipts.filter{ $0.status == .Rotten }
    }
    
    var pinnedList: [Receipt] {
        return receipts.filter{ $0.status == .Pinned }
    }
    
    init() {
        getAllReceiptData()
    }
    
    
}

extension CoreDataViewModel {
    func getAllReceiptData() {
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
    
    
    func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Error while Saving in CoreData")
        }
    }
    
    func createReceiptData() {
        
        let receipt = Receipt(context: viewContext)
        receipt.id = UUID()
        receipt.name = "TestName \(receipts.count)"
        receipt.dateOfPurchase = Date.now
        receipt.dateOfHistory = Date.distantPast
        receipt.fastEatPin = false
        receipt.icon = "icon_test"
        receipt.price = 6000.0
        receipt.status = .UnConsumed
        
        saveChanges()
        self.getAllReceiptData()
    }
    
    func deleteReceiptData(target: Receipt) {
        viewContext.delete(by: target)
        getAllReceiptData()
    }
    
    func updateReceiptStateData(target: Receipt, status: Status) {
        guard let receipt = viewContext.get(by: target.objectID) else { return }
        if status == .Pinned {
            if target.status != .UnConsumed {
                return
            }
        }
        
        receipt.state = status.rawValue
        receipt.dateOfHistory = Date.now
        
        saveChanges()
        getAllReceiptData()
    }
}
