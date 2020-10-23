//
//  sefunDataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class sefunDataCell: UITableViewCell {

    var sefunData: SefunData!
    
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

    func updata(with cellSefunData: SefunData) {
        self.sefunData = cellSefunData
        
        sefunBrandLabel.text = cellSefunData.brand
        sefunItemLabel.text  = cellSefunData.itemName
        sefunPriceLabel.text = "\(cellSefunData.price) 元"
        sefunImageCell.image = UIImage(systemName: "text.alignleft")
        SefunCacheController.shared.sefunFetchImage(url: cellSefunData.photo) { [weak self] (image) in guard let self = self else { return }
            DispatchQueue.main.async {
                if cellSefunData.pcs == self.sefunData.pcs {
                    self.sefunImageCell.image = image
                }
            }
        }
    }
    
}
