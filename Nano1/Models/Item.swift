//
//  Item.swift
//  Nano1
//
//  Created by Maria Jeffina on 10/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject {
    
    var itemImage: UIImage?
    var itemType: String?
    var itemPrice: Int?
    var isBought: Bool?
    
    private let itemKey = "item"
    private let isBoughtKey = "isBought"
    
    //initializer (probably don't need them?
    init(itemImage: UIImage, itemType: String, itemPrice: Int, isBought: Bool = false) {
        self.itemImage = itemImage
        self.itemType = itemType
        self.itemPrice = itemPrice
        self.isBought = isBought
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(itemImage, forKey: itemKey)
        coder.encode(isBought, forKey: isBoughtKey)
    }
    
    required init?(coder decoder: NSCoder) {
        guard let itemImage = decoder.decodeObject(forKey: itemKey) as? UIImage, let isBought = decoder.decodeObject(forKey: isBoughtKey) as? Bool
            else { return }
        
        self.itemImage = itemImage
        self.isBought = isBought
    }
}

