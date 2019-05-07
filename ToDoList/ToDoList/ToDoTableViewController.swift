//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by MacAir11 on 04/25/19.
//  Copyright © 2019 CCC iOS Boot Camp. All rights reserved.
//

import UIKit;

class ToDoTableViewController: UITableViewController, //p. 732
    ToDoCellDelegate {                                //p. 766
    
    var todos: [ToDo] = [ToDo]();   //p. 732
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let savedToDos: [ToDo] = ToDo.loadToDos() {   //p. 735
            todos = savedToDos;
        } else {
            todos = ToDo.loadSampleToDos()
        }

        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = editButtonItem;   //p. 740
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;   //p. 733
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count;   //p. 733
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pp. 733, 762
        guard let cell: ToDoCell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a ToDoCell");
        }

        // Configure the cell...
        let todo: ToDo = todos[indexPath.row];              //p. 734
        //cell.textLabel?.text = todo.title;                //p. 734
        cell.titleLabel?.text = todo.title;                 //p. 764
        cell.isCompleteButton.isSelected = todo.isComplete; //p. 764
        cell.delegate = self;                               //p. 766
        return cell;
    }

    // Override to support conditional editing of the table view, p. 739.

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true;
    }

    // Override to support editing the table view, p. 739.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
            ToDo.saveToDos(todos);   //p. 769
        }
    }
    
    // MARK: - ToDoCellDelegate
    
    func checkmarkTapped(sender: ToDoCell) {   //p. 766
        if let indexPath: IndexPath = tableView.indexPath(for: sender) {   //p. 767
            var todo: ToDo = todos[indexPath.row];
            todo.isComplete = !todo.isComplete;
            todos[indexPath.row] = todo;
            tableView.reloadRows(at: [indexPath], with: .automatic);
            ToDo.saveToDos(todos);   //p. 770
        }
    }
    /*
    func completeButtonTapped(_ sender: ToDoCell) {   //p. 765
        //delegate?.checkmarkTapped(sender: self);   //p. 766
        if let indexPath: IndexPath = tableView.indexPath(for: sender) {
            var todo: ToDo = todos[indexPath.row];
            todo.isComplete = !todo.isComplete;
            tableView.reloadRows(at: [indexPath], with: .automatic);
            ToDo.saveToDos(todos);
        }
    }
 */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true;
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {   //p. 758
            // Get the new view controller using segue.destination.
            let todoViewController: ToDoViewController = segue.destination as! ToDoViewController;
            // Pass the selected object to the new view controller.
            let indexPath: IndexPath = tableView.indexPathForSelectedRow!;
            todoViewController.todo = todos[indexPath.row];
        }
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) { //p. 741
        guard segue.identifier == "saveUnwind" else {           //pp. 756-757
            return;
        }
        let sourceViewController: ToDoViewController = segue.source as! ToDoViewController;
        
        if let todo: ToDo = sourceViewController.todo {
            if let selectedIndexPath: IndexPath = tableView.indexPathForSelectedRow { //pp. 760-761
                todos[selectedIndexPath.row] = todo;
                tableView.reloadRows(at: [selectedIndexPath], with: .none);
            } else {
                let newIndexPath: IndexPath = IndexPath(row: todos.count, section: 0);
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic);
            }
        }
        
        ToDo.saveToDos(todos);   //p. 770
    }
    
}
