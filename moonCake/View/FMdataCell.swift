//
//  FMdataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/5.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class FMdataCell: UITableViewCell {

    @IBOutlet weak var FMimageCell: UIImageView!
    
    @IBOutlet weak var FMbrandLabel: UILabel!
    
    @IBOutlet weak var FMitemLabel: UILabel!
    
    @IBOutlet weak var FMpriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
