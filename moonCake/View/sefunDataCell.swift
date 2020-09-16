//
//  sefunDataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class sefunDataCell: UITableViewCell {

    @IBOutlet weak var sefunImageCell: UIImageView!
    
    @IBOutlet weak var sefunBrandLabel: UILabel!
    
    @IBOutlet weak var sefunItemLabel: UILabel!
    
    @IBOutlet weak var sefunPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
