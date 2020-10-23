//
//  OrderListCacheController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/10/22.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class OrderListCacheController {
    
    static let share = OrderListCacheController()
    
    let orderImageCache = NSCache<NSURL, UIImage>()
    
    func orderFetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = orderImageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data , response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.orderImageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    func fetchOrderImage(completionHandler: @escaping ([OrderListData]?) -> ()) {
        guard let url = URL(string: "https://sheetdb.io/api/v1/6ajiyzenph1b0") else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data, let orderImageData = try? decoder.decode([OrderListData].self, from: data) {
                completionHandler(orderImageData.self)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
}
