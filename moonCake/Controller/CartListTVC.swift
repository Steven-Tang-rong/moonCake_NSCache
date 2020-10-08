//
//  CartListTVC.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/13.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class CartListTVC: UITableViewController {

    var UpdateCart = [updateCart]()
    
    let someAPI = "https://sheetdb.io/api/v1/6ajiyzenph1b0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: someAPI) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let cartResult = try? decoder.decode([updateCart].self, from: data) {
                    
                    self.UpdateCart = cartResult
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }.resume()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UpdateCart.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Identifier = "CheckoutCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as? CheckoutTableViewCell else{ return UITableViewCell() }

        let update = UpdateCart[indexPath.row]
        cell.CartProductsName.text = update.cartItemName
        cell.CartCount.text = update.cartCount
        cell.CartTotalPrice.text = update.cartTotalPrice
        cell.orderDateLabel.text = update.cartDate
        
        //圖片
     
        URLSession.shared.dataTask(with: update.cartURL) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.CartProductsImage.image = UIImage(data: data)
                }
            }
        }.resume()
 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "刪除") { (action, indexPath) in
            
            let updateCart = self.UpdateCart[indexPath.row]
            print(updateCart.cartItemName)
            
                 
    //Encoder
            let urlsString = "https://sheetdb.io/api/v1/6ajiyzenph1b0/cartItemName/\(updateCart.cartItemName)"
                    
            let url = URL(string: urlsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            var urlRequest = URLRequest(url: url!)
                    urlRequest.httpMethod = "DELETE"
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
            let deleteData = cartData(data: [updateCart])
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(deleteData) {
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data) {
                            (returnData, response, error) in
                            
            let decoder = JSONDecoder()
            if let returnData = returnData, let dic = try? decoder.decode([String: Int].self, from: returnData), dic["delete"] == 1 {
                                
                            }
                        }
                task.resume()
                self.UpdateCart.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("success")
                   
            }else {
                print("error")
            }
        }
         return [deleteAction]
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
