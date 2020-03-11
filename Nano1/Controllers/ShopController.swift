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
    func passUserPonts(_ point: Int)
}


// tanya mentor tech lain structure code disini, ada yang bisa jelasin ga, coba

enum FashionOutwear {
//    case header(headerType)
    case content(headerType)
//    case topContent
//    case bottomContent
    
    enum headerType {
        case hair
        case top
        case bottom
    }
}

class ShopController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var userPoints: UILabel!
    
    weak var delegate: PointsEntryDelegate?
    
    private var currPoints = 0
    
    let reuseIdentifier = "cell"
    
    private var sections = [FashionOutwear]()
    private var dataModel = ProductModel()
    
    
//    var itemStore: ItemStore! {
//        didSet {
//            //itemStore.items = ItemUtility.fetch() ?? [Item]
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currPoints = UserDefaults.standard.integer(forKey: "points")
        userPoints.text = String(currPoints)
        setSection()
    }
    
    //MARK: Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
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
        print("You selected it")
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to buy this?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print("You bought #\(indexPath.item)")
            
            //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! ShopCell
            //change isBought bool to true
            
            //substract the points
            self.currPoints -= Int(self.dataModel.itemPrice[indexPath.item]) ?? 0
            print(self.currPoints)
            
            self.userPoints.text = String(self.currPoints)
            //pass to the delegate protocol
            self.delegate?.passUserPonts(self.currPoints)
            
            UserDefaults.standard.set(self.currPoints, forKey: "points")
            
            //ganti userItem dengan yang udh di purchase
            if indexPath.section == 0 {
                print(self.dataModel.itemPic[indexPath.item])
                
            }
            else {
                
            }
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true)
    }
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



