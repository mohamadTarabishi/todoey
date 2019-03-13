//
//  ViewController.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 3/12/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import UIKit

class ToDoLIstviewController: UITableViewController {

    let itemArray = ["Find Milk","Buy Eggos","Destroy Demogorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewtapped))
//        tableView.addGestureRecognizer(tapGesture)

        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    //MARK: Tableview Delegate Methom
//    @objc func tableViewtapped()  {
//
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
       
        if tableView.cellForRow(at: indexPath )?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath )?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath )?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

