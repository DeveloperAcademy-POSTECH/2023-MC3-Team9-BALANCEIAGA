//
//  ReceiptViewModel.swift
//  SickSangHae
//
//  Created by user on 2023/07/15.
//

import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
    private let viewContext = CoreDataController.shared.viewContext
    @Published var receipts: [Receipt] = []
    
    init() {

    }
    
    
}

extension CoreDataViewModel {
    func getAllReceiptData() {
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        
        do {
            receipts = try viewContext.fetch(request)
        } catch {
            print("Cannot fetch receipts from SickSangHae Model")
        }
    }
}
