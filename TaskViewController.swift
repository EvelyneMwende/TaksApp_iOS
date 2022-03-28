//
//  TaskViewController.swift
//  Tasks
//
//  Created by Eclectics on 18/03/2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var task :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = task
        //adding a delete button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        
//        let newCount = count - 1
//        //because we saved the task with numbers
//        UserDefaults().setValue(newCount, forKey: "count")
//        //set nil for the count of the current task
//        UserDefaults().setValue(newCount, forKey: "task_\(currentPosition)")
//        //after deleting a task decrement the number/id asssociated with the tasks below it so we do not have a gap in between
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
