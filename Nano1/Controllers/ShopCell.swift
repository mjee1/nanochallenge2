//
//  ShopCell.swift
//  Nano1
//
//  Created by Maria Jeffina on 10/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    @IBOutlet weak var myCell:UILabel!
    @IBOutlet weak var myPic: UIImageView!
    
    var indexAt = 0
    var dataModel = ProductModel()
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    }
    
    func cellConfig(isHair: Bool, isTop: Bool, isBottom: Bool) {
        if isHair {
            myPic.image = UIImage(named: dataModel.itemPic[indexAt])
            myCell.text = dataModel.itemPrice[indexAt]
        } else if isTop {
            myPic.image = UIImage(named: dataModel.itemPic2[indexAt])
            myCell.text = dataModel.itemPrice2[indexAt]
        } else {
            myPic.image = UIImage(named: dataModel.itemPic3[indexAt])
            myCell.text = dataModel.itemPrice3[indexAt]
        }
    }
    
}
