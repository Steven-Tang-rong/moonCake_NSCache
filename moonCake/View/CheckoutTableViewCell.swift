//
//  CheckoutTableViewCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/13.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CartProductsName: UILabel!
    
    @IBOutlet weak var CartCount: UILabel!
    
    @IBOutlet weak var CartTotalPrice: UILabel!
    
    @IBOutlet weak var orderDateLabel: UILabel!
    
    
    @IBOutlet weak var CartProductsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
