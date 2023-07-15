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

