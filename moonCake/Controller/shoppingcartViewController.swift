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
    var shopGanso: gansoData?
    var shopSefun: sefunData?
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
    
   
    @IBAction func countStepper(_ sender: UIStepper) {
        let textValue = Int(sender.value)
        countTextField.text = String(textValue)
        
        let someValue = Int(priceText)
        TotalPriceLabel.text = "\(someValue! * textValue)"
    }
   
    //上傳資料
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
        let UpdataCart = updateCart(cartItemName: cartItemLabel.text!, cartCount: countTextField.text!, cartTotalPrice: TotalPriceLabel.text!, cartDate: dateString, cartURL: shopURL!)
        
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
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartImageView.contentMode = .scaleAspectFill
        countTextField.text = "1"
        countTextField.isEnabled = false
        
        
        //FM
        if let shopFM = shopFM {
            cartBrandLabel.text = shopFM.brand
            cartItemLabel.text = shopFM.itemName
            cartFlavorLabel.text = shopFM.flavor
            cartPriceLabel.text = shopFM.price
            cartIntroLabel.text = shopFM.intro
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
            cartBrandLabel.text = shopGanso.brand
            cartItemLabel.text = shopGanso.itemName
            cartFlavorLabel.text = shopGanso.flavor
            cartPriceLabel.text = shopGanso.price
            cartIntroLabel.text = shopGanso.intro
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
            cartBrandLabel.text = shopSefun.brand
            cartItemLabel.text = shopSefun.itemName
            cartFlavorLabel.text = shopSefun.flavor
            cartPriceLabel.text = shopSefun.price
            cartIntroLabel.text = shopSefun.intro
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
