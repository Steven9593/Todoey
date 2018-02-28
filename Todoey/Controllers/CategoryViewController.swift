//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Steven Gong on 2018-02-24.
//  Copyright © 2018 GongLiang. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var CategoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

    }

    
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = CategoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }
    
    //MARK: - Tableview Manipulation Methods
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print(error)
            
        }
        
        self.tableView.reloadData()
        
    }
    
  
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            CategoryArray = try context.fetch(request)
        } catch {
            print("error occured fetching data from context")
        }
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add Category", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            
            self.CategoryArray.append(newCategory)
            
            self.saveItems()
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }


    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
        }
    }

}
