//
//  FMdataCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/5.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class FMdataCell: UITableViewCell {

    var fmStationData: FMStationData!
    
    @IBOutlet weak var fmCellImage: UIImageView!
    
    @IBOutlet weak var fmBrandLabel: UILabel!
    
    @IBOutlet weak var fmItemLabel: UILabel!
    
    @IBOutlet weak var fmPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with cellFmStationData: FMStationData) {
        self.fmStationData = cellFmStationData
        
        fmBrandLabel.text = cellFmStationData.brand
        fmItemLabel.text  = cellFmStationData.itemName
        fmPriceLabel.text = "\(cellFmStationData.price) 元"
        fmCellImage.image = UIImage(systemName: "text.alignleft")
        FmCacheController.shared.fmFetchImage(url: cellFmStationData.photo) { [weak self] (image) in guard let self = self else { return }
            DispatchQueue.main.async {
                if cellFmStationData.pcs == self.fmStationData.pcs {
                    self.fmCellImage.image = image
                }
            }
        }
    }

}
