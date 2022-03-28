//
//  ViewController.swift
//  Tasks
//
//  Created by Eclectics on 17/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //IB means Interface Builder and is connected to a storyboard
    //IBOutlet lets us controll the table view on the storyboard by connecting the variable to it
    @IBOutlet var tableView: UITableView!
    
    //Array to hold all the tasks the user has entered so far
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Tasks"
        //give it a title
        //assign the tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        //save task using user default -lightweight way to save simple things
        //save count of how many tasks we have and task with a given number
        //set up initial saving mechanisms
        //If it is false set up initial default
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        //Get all current saved tasks
        updateTasks()
        
    }
    
    func updateTasks(){
        //before we update we should remove all elements in task array so there are no duplicates
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        //from 0 up to count
        for x in 0..<count{
            //iff task isn't empty add it to task array
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        //reload tableView
        tableView.reloadData()
        
    }
    // User clicking on add
    @IBAction func didTapAdd(){
        //show a view controller to show a task entry
        //Instantiate entry view controller with the id (entry) we created
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New task"
        //reload refresh table view with new tasks
        vc.update = {
            //proritize updating tasks
            DispatchQueue.main.async{
                self.updateTasks()
            }
            
        }
        //because we embedded it in a nav controller we can say
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

//what happens when we select a cell
//Supplies data and handles interactions with cells on the table view
extension ViewController: UITableViewDelegate{
    //handle taps on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Once we select a row we need to get rid of the highlight color
        tableView.deselectRow(at: indexPath, animated: true)
        //Index path is the position of the row in the table
        
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "New task"
       
        
        vc.task = tasks[indexPath.row]
        
        //because we embedded it in a nav controller we can say
        navigationController?.pushViewController(vc, animated: true)

    }
    
}
extension ViewController: UITableViewDataSource{
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Return number of things in the task array
        return tasks.count
    }
    
    //This function will be called for as many cells that are in the table view
    //return cell for a given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //D-queue a cell ->resuing the template over and over
        //swap out task/title is changing in the cells
        //We gave and id of "cell" to a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //IndesPath.row represents the position of the cell in our table view
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}

