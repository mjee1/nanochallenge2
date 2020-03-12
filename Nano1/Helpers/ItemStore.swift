//
//  ItemStore.swift
//  Nano1
//
//  Created by Maria Jeffina on 11/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation

class ItemStore {
    var items = [Item]()
    
    func setBought(_ item: Item, isBought: Bool = false, atIndex: Int) {
        if isBought == true {
            print("Item at \(atIndex) is bought")
        }
    }
}
