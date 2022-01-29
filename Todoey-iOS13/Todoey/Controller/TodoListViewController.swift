//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray.append(Item(title: "mission0", done: true))
        
//        if let items = self.defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }

    //MARK - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        return cell
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(item[indexPath.row])
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            
            self.itemArray.append(Item(title: textField.text!, done: false))
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}
