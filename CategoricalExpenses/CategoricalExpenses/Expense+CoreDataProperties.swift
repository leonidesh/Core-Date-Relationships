//
//  Expense+CoreDataProperties.swift
//  CategoricalExpenses
//
//  Created by 刘洋 on 6/29/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Double
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var category: Category?

}
