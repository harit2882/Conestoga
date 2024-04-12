//
//  ToDoListTableViewController.swift
//  harit_thoriya_8953007_LAB6
//
//  Created by Harit Thoriya on 2023-10-18.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getItems()
    }

    // MARK: - Table view data source
    var todoItems : [String] = [] {
        didSet{
            saveItem()
        }
    }
    let itemKey : String = "item_list"
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        
        let alertController = UIAlertController(title: "Add Item",
                    message: nil,
                    preferredStyle: .alert)
                
        alertController.addTextField(){
            textField in textField.placeholder = "Write an Item"
        }
        let addAction = UIAlertAction(title: "OK", style: .default){
            
            _ in
            if let todoTitle = alertController.textFields?.first?.text, !todoTitle.isEmpty {
                self.todoItems.append(todoTitle)
                self.tableView.reloadData()
            }
            
        }
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancleAction)
        
        present(alertController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicIdentifier", for: indexPath)

        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    func saveItem(){
        if let encodeedData = try? JSONEncoder().encode(todoItems) {
            UserDefaults.standard.set(encodeedData, forKey: itemKey)
        }
    }
    
    func getItems(){
        guard let data = UserDefaults.standard.data(forKey: itemKey),
              let savedItems = try? JSONDecoder().decode([String].self, from: data)
        else { return }
        
        self.todoItems = savedItems
    }

}
