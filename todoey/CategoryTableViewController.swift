//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 3/30/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var CategoryArray = [Category] ()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoudCategory()
    }
    //MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = CategoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoLIstviewController
        
        if let indexpath = tableView.indexPathForSelectedRow{
            destination.selectedCategory = CategoryArray[indexpath.row]
        }
        
    }
    
    
    
     //MARK: - Data Manipulation Methods
    func saveCategory()  {
        do{
            try context.save()
        }catch{
            print("Error Saveing Category \(error)")
        }
        tableView.reloadData()
    }
    func LoudCategory(with request: NSFetchRequest<Category> = Category.fetchRequest())  {
        do{
            CategoryArray = try context.fetch(request)
        }catch{
            print("Error Loud date \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in
            let category = Category(context: self.context)
            category.name = textField.text!
            
        self.CategoryArray.append(category)
        self.saveCategory()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
