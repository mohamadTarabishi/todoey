//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 3/30/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var Categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoudCategory()
    }
    //MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = Categories?[indexPath.row].name ?? "No Category add yet"
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoLIstviewController
        
        if let indexpath = tableView.indexPathForSelectedRow{
            destination.selectedCategory = Categories?[indexpath.row]
        }
        
    }
    
    
    
     //MARK: - Data Manipulation Methods
    func save(category : Category)  {
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error Saveing Category \(error)")
        }
        tableView.reloadData()
    }
    func LoudCategory()  {
        Categories = realm.objects(Category.self)

        
            tableView.reloadData()
    }
    
    
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in
            let category = Category()
            category.name = textField.text!
  
            self.save(category :category )
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
