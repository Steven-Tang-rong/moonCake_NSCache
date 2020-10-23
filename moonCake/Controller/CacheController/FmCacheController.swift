//
//  fmCacheController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/10/13.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class FmCacheController{
    static let shared = FmCacheController()
    
    // 產生 NSCache 物件
    let fmImageCache = NSCache<NSURL, UIImage>()
    
    // 抓圖function，NSCache儲存抓過的圖片
    func fmFetchImage(url: URL, completionHandler: @escaping (UIImage?) -> () ) {
        if let image = fmImageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        //從網路抓圖後，將圖片存入 cache。
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.fmImageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    
    func fetchFMImage(completionHandler: @escaping ([FMStationData]?) -> ()) {
        guard let url = URL(string: "https://sheetdb.io/api/v1/fim6gdre7wzmi") else {
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data , let fmImageData = try? decoder.decode([FMStationData].self, from: data) {
                completionHandler(fmImageData.self)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
}
