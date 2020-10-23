//
//  GansoCacheController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/10/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class GansoCacheController {
    static let shared = GansoCacheController()
    
    let gansoImageCache = NSCache<NSURL, UIImage>()
    
    func gansoFetchImage(url: URL, completionHandler: @escaping (UIImage?) -> () ) {
        if let image = gansoImageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.gansoImageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    func fetchGansoImage(completionHandler: @escaping([GansoData]?) -> ()) {
        guard let url = URL(string: "https://sheetdb.io/api/v1/adu98qbmb9tq6") else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data, let gansoImageData = try? decoder.decode([GansoData].self, from: data) {
                completionHandler(gansoImageData.self)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
}
