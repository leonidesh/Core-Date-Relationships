//
//  CategoriesViewController.swift
//  ExpensesCoreData
//
//  Created by Shawn Moore on 11/9/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories:[Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as?  AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
           categories =  try managedContext.fetch(fetchRequest)
           categoriesTableView.reloadData()
            
        }catch{
            print("Could not fetch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ExpensesViewController,
             let selectedRow = self.categoriesTableView.indexPathForSelectedRow?.row else{
                return
        }
        
        destination.category = categories[selectedRow]
    }

    func deleteCategory(at inexPath: IndexPath){
        let category = categories[inexPath.row]
        guard let mannagedContext = category.managedObjectContext else{
            return
        }
        
        mannagedContext.delete(category)
        
        do{
            try mannagedContext.save()
            
            categories.remove(at: inexPath.row)
            
            categoriesTableView.deleteRows(at: [inexPath], with: .automatic)
        }catch{
            print("Could not delete")
            categoriesTableView.reloadRows(at: [inexPath], with: .automatic)
        }
    }
    
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategory(at: indexPath)
        }
    }
}
