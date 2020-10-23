//
//  CartListTVC.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/13.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class OrderListTVC: UITableViewController {

    var orderListData = [OrderListData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OrderListCacheController.share.fetchOrderImage { [weak self] (orderListData) in
            guard let self = self else { return }
            if let orderListData = orderListData {
                self.orderListData = orderListData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderListData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Identifier = "CheckoutCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as? OrderListTableViewCell else{ return UITableViewCell() }

        let orderData = orderListData[indexPath.row]
        cell.updata(with: orderData)
 
        
        return cell
    }
    
    
 //刪除sheetDB資料
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "刪除") { (action, indexPath) in
            
            let updateCart = self.orderListData[indexPath.row]
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
                self.orderListData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("success")
                   
            }else {
                print("error")
            }
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.4934554561, blue: 0.5243053216, alpha: 1)
        
         return [deleteAction]
    }

}
