//
//  SefunCacheController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/10/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class SefunCacheController {
    static let shared = SefunCacheController()
    
    let sefunImageCache = NSCache<NSURL, UIImage>()
    
    func sefunFetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = sefunImageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.sefunImageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    func fetchSefunImage(completionHandler: @escaping([SefunData]?) -> ()) {
        guard let url = URL(string: "https://sheetdb.io/api/v1/9rl4gvgb8tiy1") else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data, let sefunImageData = try? decoder.decode([SefunData].self, from: data) {
                completionHandler(sefunImageData.self)
            }else {
                completionHandler(nil)
            }
        }.resume()
    }
}
