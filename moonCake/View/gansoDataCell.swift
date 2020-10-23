//
//  gansoDataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class gansoDataCell: UITableViewCell {

    var gansoData: GansoData!
    
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
    
    func update(with cellGansoData: GansoData) {
        self.gansoData = cellGansoData
        
        gansoBrandLabel.text = cellGansoData.brand
        gansoItemLabel.text  = cellGansoData.itemName
        gansoPriceLabel.text = "\(cellGansoData.price) 元"
        gansoImageCell.image = UIImage(systemName: "text.alignleft")
        GansoCacheController.shared.gansoFetchImage(url: cellGansoData.photo) { [weak self] (image) in guard let self = self else { return }
            DispatchQueue.main.async {
                if cellGansoData.pcs == self.gansoData.pcs {
                    self.gansoImageCell.image = image
                }
            }
        }
    }

}
