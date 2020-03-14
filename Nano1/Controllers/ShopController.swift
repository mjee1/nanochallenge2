//
//  StoreController.swift
//  Nano1
//
//  Created by Maria Jeffina on 09/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit

//MARK: Protocol
protocol PointsEntryDelegate: AnyObject {
    func passUserPoints(_ point: Int)
    func passImageName(_ imgName: String,  _ section: Int)
}


enum FashionOutwear {
    case content(headerType)
    
    enum headerType {
        case hair
        case top
        case bottom
    }
}

class ShopController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var userPoints: UILabel!
    
    weak var pointEntryDelegate: PointsEntryDelegate!
    
    var currPoints = 0
    
    
    let reuseIdentifier = "cell"
    
    private var sections = [FashionOutwear]()
    private var dataModel = ProductModel()
    private var myCell = ShopCell()
    
    private var currBool:[String] = [
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false"
    ]
    
    private var currBool2:[String] = [
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false",
        "false"
    ]
    
    //For Bottom
    private var currBool3:[String] = [
        "false",
        "false",
        "false",
        "false",
        "false",
        "false"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currBool = UserDefaults.standard.stringArray(forKey: "userBool1") ?? currBool
        currBool2 = UserDefaults.standard.stringArray(forKey: "userBool2") ?? currBool2
        currBool3 = UserDefaults.standard.stringArray(forKey: "userBool3") ?? currBool3
        
        currPoints = UserDefaults.standard.integer(forKey: "points")
        userPoints.text = String(currPoints)
        setSection()
        
    }
    
    //MARK: Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .content(.hair):
            return dataModel.itemPic.count
        case .content(.top):
            return dataModel.itemPic2.count
        case .content(.bottom):
            return dataModel.itemPic3.count
        }
//        return (section == 0) ? itemPic.count : itemPic2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeader", for: indexPath) as? SectionHeader {
            if indexPath.section == 0 {
                sectionHeader.sectionLabel.text = "Hair"
            }
            else if indexPath.section == 1 {
                sectionHeader.sectionLabel.text = "Top"
            }
            else {
                sectionHeader.sectionLabel.text = "Bottom"
            }

            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
        case .content(let type):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShopCell
            cell.indexAt = indexPath.row
            
            var isHair = false
            var isTop = false
            var isBottom = false
            
            switch type {
            case .hair:
                isHair = true
            case .top:
                isTop = true
            case .bottom:
                isBottom = true
            }

            cell.cellConfig(isHair: isHair, isTop: isTop, isBottom: isBottom)
//            Item(itemImage: self.itemPic[indexPath.item], itemType: self.itemTypes[0], itemPrice: Int(self.itemPrice[indexPath.item]) ?? 0, isBought: false)
            return cell
        }
    }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var tempArr = self.currBool
        
        switch indexPath.section {
        case 0:
            tempArr = self.currBool
        case 1:
            tempArr = self.currBool2
        default:
            tempArr = self.currBool3
        }
        print("tempArr is \(tempArr)")
        
        if (tempArr[indexPath.item] == "true"){
            
            
            let alertController = UIAlertController(title: "Item Equipped", message: "You have successfully equipped the item", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .cancel)
            
            if indexPath.section == 0 {
                self.pointEntryDelegate?.passImageName(self.dataModel.itemPic[indexPath.row], indexPath.section)
                print("Changing hair...")
            }
            else if indexPath.section == 1 {
                self.pointEntryDelegate?.passImageName(self.dataModel.itemPic2[indexPath.row], indexPath.section)
                print("Changing top...")
            }
            else if indexPath.section == 2 {
                self.pointEntryDelegate?.passImageName(self.dataModel.itemPic3[indexPath.row], indexPath.section)
                print("Changing bottom...")
            }
            
            alertController.addAction(OKAction)
            present(alertController, animated: true)
        }
        
        else {
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to buy this?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ShopCell
                //change isBought bool to true
                var tempPrice = self.currPoints - Int(self.dataModel.itemPrice[indexPath.item])!
                
                switch indexPath.section {
                case 0:
                    tempPrice = self.currPoints - Int(self.dataModel.itemPrice[indexPath.item])!
                case 1:
                    tempPrice = self.currPoints - Int(self.dataModel.itemPrice2[indexPath.item])!
                default:
                    tempPrice = self.currPoints - Int(self.dataModel.itemPrice3[indexPath.item])!
                }
                
                //substract the points
                if tempPrice >= 0 {
                    if indexPath.section == 0 {
                        self.currPoints -= Int(self.dataModel.itemPrice[indexPath.item]) ?? 0
                        self.currBool[indexPath.item] = "true"
                        UserDefaults.standard.set(self.currBool, forKey: "userBool1")
                    }
                    else if indexPath.section == 1 {
                        self.currPoints -= Int(self.dataModel.itemPrice2[indexPath.item]) ?? 0
                        self.currBool2[indexPath.item] = "true"
                        UserDefaults.standard.set(self.currBool2, forKey: "userBool2")
                    }
                    else if indexPath.section == 2 {
                        self.currPoints -= Int(self.dataModel.itemPrice3[indexPath.item]) ?? 0
                        self.currBool3[indexPath.item] = "true"
                        UserDefaults.standard.set(self.currBool3, forKey: "userBool3")
                    }
                        
                    self.userPoints.text = String(self.currPoints)
                    
                    //MARK: Passing Delegate
                    self.pointEntryDelegate?.passUserPoints(self.currPoints)
                    UserDefaults.standard.set(self.currPoints, forKey: "points")
                    
                    //Ganti user
                    if indexPath.section == 0 {
                        self.pointEntryDelegate?.passImageName(self.dataModel.itemPic[indexPath.row], indexPath.section)
                        
                    }
                    else if indexPath.section == 1 {
                        self.pointEntryDelegate?.passImageName(self.dataModel.itemPic2[indexPath.row], indexPath.section)
                    }
                    else if indexPath.section == 2 {
                        self.pointEntryDelegate?.passImageName(self.dataModel.itemPic3[indexPath.row], indexPath.section)
                    }
                }
                else {
                    //Show another alert showing that you don't have enough points
                    print("Don't have enough points")
                    let alert = UIAlertController(title: "Not Enough Points", message: "Sorry but you don't have enough points", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                }
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel)
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            present(alertController, animated: true)
        }
    }
    
    //MARK: Personal Function
    
}


private extension ShopController {
    func setSection() {
        sections.removeAll()
        if !dataModel.itemPic.isEmpty {
//            sections.append(.header(.hair))
            sections.append(.content(.hair))
        } else if dataModel.itemPic.isEmpty {
            // do not append anything with Hair section to UI
        }
        if !dataModel.itemPic2.isEmpty {
//            sections.append(.header(.top))
            sections.append(.content(.top))
        } else if dataModel.itemPic2.isEmpty {
            // do not append anything with Top section to UI
        }
        if !dataModel.itemPic3.isEmpty {
//            sections.append(.header(.bottom))
            sections.append(.content(.bottom))
        } else if dataModel.itemPic3.isEmpty {
            // do not append anything with Top section to UI
        }
    }
}



