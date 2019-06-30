//
//  Category+CoreDataClass.swift
//  CategoricalExpenses
//
//  Created by 刘洋 on 6/29/19.
//  Copyright © 2019 Shawn Moore. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    var expenses:[Expense]?{
        return self.rawExpenses?.array as? [Expense]
    }
    
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        
        self.init(entity: Category.entity(), insertInto: context)
        self.title = title
    }
    
}
