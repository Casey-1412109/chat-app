//
//  MsgCellTableViewCellTableViewCell.swift
//  Flash Chat iOS13
//
//  Created by Casey on 26/06/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MsgCellTableViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var A: UIImageView!
    @IBOutlet weak var V: UIView!
    @IBOutlet weak var view: UIStackView!
    @IBOutlet weak var se: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        V.layer.cornerRadius = V.frame.size.height / 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
