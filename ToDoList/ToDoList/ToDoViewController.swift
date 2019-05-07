//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by MacAir11 on 04/25/19.
//  Copyright © 2019 CCC iOS Boot Camp. All rights reserved.
//

import UIKit;

class ToDoViewController: UITableViewController {   //p. 746
    
    var todo: ToDo? = nil;           //p. 756
    var isPickerHidden: Bool = true; //p. 752

    @IBOutlet weak var titleTextField: UITextField!;   //p. 747
    @IBOutlet weak var isCompleteButton: UIButton!;
    @IBOutlet weak var dueDateLabel: UILabel!;
    @IBOutlet weak var dueDatePickerView: UIDatePicker!;
    @IBOutlet weak var notesTextView: UITextView!;
    @IBOutlet weak var saveButton: UIBarButtonItem!;   //p. 747
    
    override func viewDidLoad() {
        super.viewDidLoad();

        if let todo: ToDo = todo {   //p. 759
            navigationItem.title = "To-Do";
            titleTextField.text = todo.title;
            isCompleteButton.isSelected = todo.isComplete;
            dueDatePickerView.date = todo.dueDate;
            notesTextView.text = todo.notes;
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(60 * 60 * 24); //p. 752
        }
        
        updateDueDateLabel(date: dueDatePickerView.date); //p. 751
        updateSaveButtonState();                          //p. 747


        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // navigationItem.rightBarButtonItem = editButtonItem;
    }
    
    // MARK: - @IBActions
    
    @IBAction func textEditingChanged(_ sender: UITextField) {   //p. 748
        updateSaveButtonState();
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {   //pp. 748-749
        titleTextField.resignFirstResponder();
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {   //p. 749
        isCompleteButton.isSelected = !isCompleteButton.isSelected;
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {   //p. 751
        updateDueDateLabel(date: dueDatePickerView.date);
    }
    
    // MARK: - update methods

    func updateSaveButtonState() {   //p. 747
        let text: String = titleTextField.text ?? "";
        saveButton.isEnabled = !text.isEmpty;
    }
    
    func updateDueDateLabel(date: Date) {   //p. 751
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date);
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0;
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath);

        // Configure the cell...
        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true;
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //p. 753
        let normalCellHeight: CGFloat = 44;
        let largeCellHeight: CGFloat = 200;

        switch indexPath {
        case [1, 0]: //Due Date Cell
            return isPickerHidden ? normalCellHeight : largeCellHeight;
    
        case [2, 0]: //Notes Cell
            return largeCellHeight;
            
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {   //p. 754
        switch indexPath {
        case [1, 0]:   //Due Date Cell
            isPickerHidden = !isPickerHidden;
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor;
            tableView.beginUpdates();
            tableView.endUpdates();
        default:
            break;
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    // p. 755
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        guard segue.identifier == "saveUnwind" else {
            return;
        }
        
        let title: String = titleTextField.text!;
        let isComplete: Bool = isCompleteButton.isSelected;
        let dueDate: Date = dueDatePickerView.date;
        let notes: String = notesTextView.text;
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes);  //p. 756
    }

}
