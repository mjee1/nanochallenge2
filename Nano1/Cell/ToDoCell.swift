//
//  ToDoCell.swift
//  Nano1
//
//  Created by Maria Jeffina on 04/03/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var contentCell: UILabel!
    var object: Task? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig() {
        guard let obj = object else { return }
        contentCell.text = obj.name
    }

}
