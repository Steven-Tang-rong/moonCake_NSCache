//
//  CheckoutTableViewCell.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/13.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    var orderData: OrderListData!
    
    @IBOutlet weak var orderProductsName: UILabel!
    
    @IBOutlet weak var orderCount: UILabel!
    
    @IBOutlet weak var orderTotalPrice: UILabel!
    
    @IBOutlet weak var orderDateLabel: UILabel!
    
    
    @IBOutlet weak var orderProductsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updata(with cellOrderData: OrderListData) {
        self.orderData = cellOrderData
        
        orderProductsName.text   = cellOrderData.cartItemName
        orderCount.text          = "數量： \(cellOrderData.cartCount) 個"
        orderDateLabel.text      = cellOrderData.cartDate
        orderTotalPrice.text     = "\(cellOrderData.cartTotalPrice) 元"
        orderProductsImage.image = UIImage(systemName: "text.alignleft")
        
        OrderListCacheController.share.orderFetchImage(url: cellOrderData.cartURL) { [weak self] (image) in guard let self = self else { return }
            DispatchQueue.main.async {
                if cellOrderData.cartCount == self.orderData.cartCount {
                    self.orderProductsImage.image = image
                }
            }
        }
    }
}
