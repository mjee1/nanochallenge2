//
//  TaskStore.swift
//  Nano1
//
//  Created by Maria Jeffina on 03/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class TaskStore {
    
    var tasks = [[Task](), [Task]()]
    
    //MARK: addTask
    func add(_ task: Task, at index: Int, isDone: Bool = false){
        
        //if it's done taro di section 1, else section 0
        let section = isDone ? 1 : 0
        tasks[section].insert(task, at: index)
    }
    
    
    //MARK: removeTask
    @discardableResult func remove(at index: Int, isDone: Bool = false) -> Task {
        
        //return a task
        let section = isDone ? 1 : 0
        return tasks[section].remove(at: index)
    }
}
