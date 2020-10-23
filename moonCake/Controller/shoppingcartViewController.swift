//
//  shoppingcartViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/7.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class shoppingcartViewController: UIViewController {

    //Model
    var shopFM: FMStationData?
    var shopGanso: GansoData?
    var shopSefun: SefunData?
    var shopURL: URL?
    
    var priceText = String()
    
    //Outlet & Action
    @IBOutlet weak var cartImageView: UIImageView!
    
    @IBOutlet weak var cartBrandLabel: UILabel!
    
    @IBOutlet weak var cartItemLabel: UILabel!
    
    @IBOutlet weak var cartFlavorLabel: UILabel!
    
    @IBOutlet weak var cartPriceLabel: UILabel!
    
    @IBOutlet weak var TotalPriceLabel: UILabel!
    
    @IBOutlet weak var cartIntroLabel: UILabel!
    
    @IBOutlet weak var countTextField: UITextField!
    
    @IBOutlet weak var countStepper: UIStepper!
    
    @IBAction func addCountStepper(_ sender: UIStepper) {
        let textValue = Int(sender.value)
        countTextField.text = String(textValue)
        
        let someValue = Int(priceText)
        TotalPriceLabel.text = "\(someValue! * textValue) 元"
    }
   
//MARK: - 上傳資料
    
    @IBAction func cartButton(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = formatter.string(from: date)
        
        let updateURL = "https://sheetdb.io/api/v1/6ajiyzenph1b0"
        let url = URL(string: updateURL)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
  //資料
        let UpdataCart = OrderListData(cartItemName: cartItemLabel.text!, cartCount: countTextField.text!, cartTotalPrice: TotalPriceLabel.text!, cartDate: dateString, cartURL: shopURL!)
        
        let CartData = cartData(data: [UpdataCart])
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(CartData){
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (returnData, response, error) in
                
                let decoder = JSONDecoder()
                
                if let returnData = returnData, let dic = try? decoder.decode([String: Int].self, from: returnData), dic["created"] == 1 {
                    
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    print("ok")
                }else {
                    print("error")
                }
            }
            task.resume()
        }
    }
    
//MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartImageView.contentMode = .scaleAspectFill
        countTextField.isEnabled = false
        countTextField.text = "1"
        countStepper.value = 1
        countStepper.minimumValue = 1
        
        //FM
        if let shopFM = shopFM {
            if shopFM.intro != "" {
                cartIntroLabel.text = "商品介紹：\n\(shopFM.intro)"
            }else {
                cartIntroLabel.text = "商品介紹：\n該商品尚未有介紹內容"
            }
            
            cartBrandLabel.text = shopFM.brand
            cartItemLabel.text = shopFM.itemName
            cartFlavorLabel.text = "口味： \(shopFM.flavor)"
            cartPriceLabel.text = "\(shopFM.price) 元"
            priceText = shopFM.price
            shopURL = shopFM.photo
            
            URLSession.shared.dataTask(with: shopFM.photo) {(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.cartImageView.image = UIImage(data: data)!
                    }
                }
            }.resume()
        }
       
        //Ganso
        if let shopGanso = shopGanso {
            if shopGanso.intro != "" {
                cartIntroLabel.text = "商品介紹：\n\(shopGanso.intro)"
            }else {
                cartIntroLabel.text = "商品介紹：\n該商品尚未有介紹內容"
            }
            
            cartBrandLabel.text = shopGanso.brand
            cartItemLabel.text = shopGanso.itemName
            cartFlavorLabel.text = "口味： \(shopGanso.flavor)"
            cartPriceLabel.text = "\(shopGanso.price) 元"
            priceText = shopGanso.price
            shopURL = shopGanso.photo
            
            URLSession.shared.dataTask(with: shopGanso.photo) {(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.cartImageView.image = UIImage(data: data)!
                    }
                }
            }.resume()
            
        }
        
        //Sefun
        if let shopSefun = shopSefun {
            if shopSefun.intro != "" {
                cartIntroLabel.text = "商品介紹：\n\(shopSefun.intro)"
            }else {
                cartIntroLabel.text = "商品介紹：\n該商品尚未有介紹內容"
            }
            
            cartBrandLabel.text = shopSefun.brand
            cartItemLabel.text = shopSefun.itemName
            cartFlavorLabel.text = "口味： \(shopSefun.flavor)"
            cartPriceLabel.text = "\(shopSefun.price) 元"
            priceText = shopSefun.price
            shopURL = shopSefun.photo
            
            URLSession.shared.dataTask(with: shopSefun.photo) {(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.cartImageView.image = UIImage(data: data)!
                    }
                }
            }.resume()
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
          TotalPriceLabel.text = cartPriceLabel.text
      }
  
    

}
