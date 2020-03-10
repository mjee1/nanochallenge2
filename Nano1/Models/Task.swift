//
//  Task.swift
//  Nano1
//
//  Created by Maria Jeffina on 03/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    var name: String?
    var isDone: Bool?
    
    private let nameKey = "name"
    private let isDoneKey = "isDone"
    
    //initializer
    init(name:String, isDone:Bool = false) {
        self.name = name
        self.isDone = isDone
    }
    
    func encode(with aCoder: NSCoder) {
        //encode every properties
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(isDone, forKey: isDoneKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //isDone must be bool
        //name must be string
        
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
            let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool
            else { return }
        
        self.name = name
        self.isDone = isDone
    }
}
