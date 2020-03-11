//
//  ItemUtility.swift
//  Nano1
//
//  Created by Maria Jeffina on 11/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class ItemUtility {
    private static let key = "items"
    
    //MARK: Aarchive
    private static func archive(_ items: [Item]) -> Data? {
            return try? NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
        }
        
    //MARK: FETCH
        static func fetch() -> [Item]? {
            guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [Item] ?? []
        }
        
    //MARK: SAVE
        static func save (_ items: [Item]) {
            //Archive
            let archiveTask = archive(items)
            //Set Object for Key
            UserDefaults.standard.set(archiveTask, forKey: key)
            UserDefaults.standard.synchronize()
        }
}
