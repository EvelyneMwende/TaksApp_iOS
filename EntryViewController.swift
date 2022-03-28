//
//  EntryViewController.swift
//  Tasks
//
//  Created by Eclectics on 18/03/2022.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    //task details
    @IBOutlet var field:UITextField!
    var update: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        field.delegate = self
        
        //Adding a save button using code
        //selector used to call function saveTask when button is clicked
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done,
                target: self, action: #selector(saveTask))
    }
    
    //once person hits enter on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        //save our content in the text view
        //make sure content isnt empty using guard if there is save it to text variable
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        //save task using user default -lightweight way to save simple things
        //save count of how many tasks we have and task with a given number
        //when we want to save an entry-> get count increment by 1  and save the task we entered in text
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        //incrementing count whenever a new entry is made
        let newCount = count + 1
        //saving data
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        //? means if thsi function exists call it
        update?()
        navigationController?.popViewController(animated: true)
        
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
