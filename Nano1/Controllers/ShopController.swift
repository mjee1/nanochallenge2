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
    var items = ["1", "2", "3", "4", "5", "6"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Data Source protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShopCell
        
        cell.myCell.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan
        
        return cell
    }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected it")
    }
}


