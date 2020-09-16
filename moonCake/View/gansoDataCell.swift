//
//  gansoDataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class gansoDataCell: UITableViewCell {

    @IBOutlet weak var gansoImageCell: UIImageView!
    
    @IBOutlet weak var gansoBrandLabel: UILabel!
    
    @IBOutlet weak var gansoItemLabel: UILabel!
    
    @IBOutlet weak var gansoPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
