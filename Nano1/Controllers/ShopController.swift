//
//  StoreController.swift
//  Nano1
//
//  Created by Maria Jeffina on 09/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit

class ShopController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let reuseIdentifier = "cell"
    var itemPrice = ["1", "2", "3", "4", "5", "6"]
    var itemPic:[UIImage] = [
        UIImage(named: "maleHair1.png")!,
        UIImage(named: "maleHair1.png")!,
        UIImage(named: "maleHair1.png")!,
        UIImage(named: "maleHair1.png")!,
        UIImage(named: "maleHair1.png")!,
        UIImage(named: "maleHair1.png")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Data Source protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemPrice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShopCell
        
        cell.myPic.image = self.itemPic[indexPath.item]
        cell.myCell.text = self.itemPrice[indexPath.item]
        cell.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        return cell
    }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected it")
    }
}


