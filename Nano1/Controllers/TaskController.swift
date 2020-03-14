//
//  TaskController.swift
//  Nano1
//
//  Created by Maria Jeffina on 03/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit



class TaskController:UITableViewController {
    
    
    @IBOutlet weak var character: UIImageView!
    
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userTask: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var outletName: UILabel!
    
    @IBOutlet weak var userHair: UIImageView!
    @IBOutlet weak var userTop: UIImageView!
    @IBOutlet weak var userBottom: UIImageView!
    
    
    var progress = 0.0
    var pointIncr = 0
    var taskDoneCounter = 0
    var level = 1
    
    var userName = "Jane Doe"
    
    var user: [String: String] = [
        "hair": "maleHair1.png",
        "top": "maleTop1.png",
        "bottom": "maleBottom1.png"
    ]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sh:ShopController = segue.destination as! ShopController
        sh.pointEntryDelegate = self
    }
    
    // Panggil method to store tasks in the MVC
    var taskStore: TaskStore! {
        didSet {
            taskStore.tasks = TaskUtility.fetch() ?? [[Task](), [Task]()]
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        // Called everytime it loads, not appear
        super.viewDidLoad()
        
        pointIncr += UserDefaults.standard.integer(forKey: "points")
        taskDoneCounter = UserDefaults.standard.integer(forKey: "taskDone")
        progress = UserDefaults.standard.double(forKey: "levelProgress")
        level = UserDefaults.standard.integer(forKey: "level")
        userName = UserDefaults.standard.string(forKey: "userName") ?? "Your Name"
        
        
        self.userPoints.text = String(pointIncr)
        self.userTask.text = String(taskDoneCounter)
        self.levelProgress.progress = Float(progress)
        self.userLevel.text = String(level)
        self.outletName.text = self.userName
        
        //MARK: UserCharacterConfig
        user["hair"] = UserDefaults.standard.string(forKey: "userHair") ?? "maleHair1.png"
        user["top"] = UserDefaults.standard.string(forKey: "userTop") ?? "maleTop1.png"
        user["bottom"] = UserDefaults.standard.string(forKey: "userBottom") ?? "maleBottom1.png"
        
        
        
        userHair.image = UIImage(named: user["hair"]!)
        userTop.image = UIImage(named: user["top"]!)
        userBottom.image = UIImage(named: user["bottom"]!)
        
        // MARK: - Progress View Setting
        levelProgress.transform = levelProgress.transform.scaledBy(x: 1, y: 6)
        levelProgress.layer.cornerRadius = 10
        levelProgress.clipsToBounds = true
        levelProgress.layer.sublayers![1].cornerRadius = 10
        levelProgress.subviews[1].clipsToBounds = true
        
        // Load Gif
        character.loadGif(name: "char")
        
        
    }
    
    //MARK: Add Task
    @IBAction func addTask(_ sender: Any) {
        // Setting up alert controller
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        // Setup actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            // Kalau textnya ketemu kita ambil hasilnya kalo enggak ya return
            guard let name = alertController.textFields?.first?.text else {return}
            // Create task
            let newTask = Task(name: name)
            
            // Add task
            self.taskStore.add(newTask, at: 0)
            
            // Reload Table view
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            // Save
            TaskUtility.save(self.taskStore.tasks)
            
        }
        
        addAction.isEnabled = false
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter task name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        })
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    //MARK: Edit Name
    @IBAction func editName(_ sender: Any) {
        let alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
                
        //Setup actions
        let addAction = UIAlertAction(title: "Confirm", style: .default) { _ in
        
            guard let name = alertController.textFields?.first?.text else {return}
            self.userName = name
            self.outletName.text = self.userName
                
            UserDefaults.standard.set(self.userName, forKey: "userName")
        }
                    
        addAction.isEnabled = false
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        })
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
            
        present(alertController, animated: true)
    }
    
    
    
    @objc private func handleTextChanged(_ sender: UITextField) {
        
        guard let alertController = presentedViewController as? UIAlertController,
            let addAction = alertController.actions.first,
            let text = sender.text
            
            else { return }
        
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
        
    }
    
}

//MARK: Protocol Delegate
extension TaskController: PointsEntryDelegate {
    func passImageName(_ imgName: String, _ section: Int) {
        if section == 0 {
            //Change hair image
            self.userHair.image = UIImage(named: imgName)
            UserDefaults.standard.set(imgName, forKey: "userHair")
            print("hair is saved with \(imgName)")
        }
        else if section == 1 {
            self.userTop.image = UIImage(named: imgName)
            UserDefaults.standard.set(imgName, forKey: "userTop")
            print("top is saved with \(String(describing: UserDefaults.standard.string(forKey: "userTop")))")
        }
        else if section == 2 {
            self.userBottom.image = UIImage(named: imgName)
            UserDefaults.standard.set(imgName, forKey: "userBottom")
            print("top is saved with \(String(describing: UserDefaults.standard.string(forKey: "userTop")))")
        }
        UserDefaults.standard.synchronize()
        
        
        
    }
    
    func passUserPoints(_ point: Int) {
        self.pointIncr = point
        DispatchQueue.main.async {
            self.userPoints.text = String(self.pointIncr)
        }
        print("Delegate run, adding \(point) to userPoints")
    }
}

// MARK: - Data Source
extension TaskController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //if it's section 0, return "To Do", else "Done"
        return section == 0 ? "To-Do" : "Done"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows to be showed FOR EACH SECTION
        return taskStore.tasks[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoCell)!
        cell.object = taskStore.tasks[indexPath.section][indexPath.row]
        return cell
    }
}

//MARK: - Delegate
extension TaskController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 3
        }
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red:0.84, green:0.93, blue:1.00, alpha:1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    // MARK: Trailing Action
    // swiping to the left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            
            guard let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone else {return}
            
            self.taskStore.remove(at: indexPath.row, isDone: isDone)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.8950964808, green: 0.14391312, blue: 0.2238836288, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    // MARK: Leading Action
    // swiping to the right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //untuk Done
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            
            //Toggle that task is done
            self.taskStore.tasks[0][indexPath.row].isDone = true
            
            //Remove tasks from the array containing to do task
            let doneTask = self.taskStore.remove(at: indexPath.row)
            
            //Reload to-do section table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //Add tasks to the array containing done task (done section)
            self.taskStore.add(doneTask, at: 0, isDone: true)
            
            //Reload table view for done section
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            
            self.pointIncr += Int.random(in: 2...5)
            self.userPoints.text = String(self.pointIncr)
            
            
            self.taskDoneCounter += 1
            self.userTask.text = String(self.taskDoneCounter)
            
            
            self.progress += 0.2/Double(self.level)
            self.levelProgress.progress = Float(self.progress)
            
            
            // Level-Up
            if self.progress >= 1 {
                self.level += 1
                self.userLevel.text = String(self.level)
                self.progress = 0
                //self.levelProgress.progress = Float(self.progress)
            }
            
            //Data need to be saved
            UserDefaults.standard.set(self.level, forKey: "level")
            UserDefaults.standard.set(self.progress, forKey: "levelProgress")
            UserDefaults.standard.set(self.taskDoneCounter, forKey: "taskDone")
            UserDefaults.standard.set(self.pointIncr, forKey: "points")
            
            TaskUtility.save(self.taskStore.tasks)
            
            completionHandler(true)
            
            
        }
        
        doneAction.image = UIImage(named: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.1600575447, green: 0.8670783639, blue: 0.3545378745, alpha: 1)
        
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
    }
}


