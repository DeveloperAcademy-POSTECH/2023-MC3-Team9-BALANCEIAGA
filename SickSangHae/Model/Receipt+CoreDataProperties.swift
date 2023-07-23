//
//  Receipt+CoreDataProperties.swift
//  SickSangHae
//
//  Created by user on 2023/07/13.
//
//

import CoreData
import Foundation


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var currentState: Int16
    @NSManaged public var previousState: Int16
    @NSManaged public var category: Int16
    @NSManaged public var price: Double
    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var icon: String
    @NSManaged public var dateOfPurchase: Date
    @NSManaged public var dateOfHistory: Date
    @NSManaged public var placeOfPurchase: String?

    var currentStatus: Status {
        get {
            return Status(rawValue: self.currentState) ?? .shortTermUnEaten
        }
        set {
            self.currentState = newValue.rawValue
        }
    }
    
    var previousStatus: Status {
        get {
            return Status(rawValue: self.previousState) ?? .shortTermUnEaten
        }
        set {
            self.currentState = newValue.rawValue
        }
    }
    
    
    var itemCategory: Categories {
        get {
            return Categories(rawValue: self.category) ?? .Unknown
        }
        set {
            self.category = newValue.rawValue
        }
    }
}

extension Receipt : Identifiable {

}
