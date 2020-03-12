//
//  ItemUtility.swift
//  Nano1
//
//  Created by Maria Jeffina on 12/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class ItemUtility {
    private static let key = "items"
    
    //MARK: Archive
    private static func archive(_ items: [Item]) -> Data {
        return try! NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
    }
    
    //MARK: Fetch
    static func fetch() -> [Item]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else {return nil}
        return try?
        NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [Item] ?? []
    }
    
    //MARK: Save
    static func save (_ items: [Item]) {
        let archiveItem = archive(items)
        UserDefaults.standard.set(archiveItem, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
