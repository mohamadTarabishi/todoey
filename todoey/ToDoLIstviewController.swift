//
//  ViewController.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 3/12/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoLIstviewController: UITableViewController{

    var todoItems : Results<Item>?
   let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
           loudItem()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

       print("the file \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")

        
        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else{
            cell.textLabel?.text = "No Items Addes yet"
                    }
       
      
                
        return cell
        
    }
    //MARK: Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status , \(error)")
            }
            self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    //MARK: Add New item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user clicks the add Item button on our UIAlert
            
            
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.Items.append(newItem)
                    }
                }catch{
                    print("Error Saving new Item , \(error)")
                }
               
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
    func loudItem(){

        todoItems = selectedCategory?.Items.sorted(byKeyPath: "title",ascending: true)        
        tableView.reloadData()
    }


}
//MARK: - Search bar methods
extension ToDoLIstviewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems =  todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loudItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
