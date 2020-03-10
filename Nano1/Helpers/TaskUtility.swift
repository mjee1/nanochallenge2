//
//  TaskUtility.swift
//  Nano1
//
//  Created by Maria Jeffina on 03/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class TaskUtility {
    private static let key = "tasks"
    
//MARK: ARCHIVE
    private static func archive(_ tasks: [[Task]]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
    }
    
//MARK: FETCH
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[Task]] ?? [[]]
    }
    
//MARK: SAVE
    static func save (_ tasks: [[Task]]) {
        //Archive
        let archiveTask = archive(tasks)
        //Set Object for Key
        UserDefaults.standard.set(archiveTask, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
