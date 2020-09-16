//
//  gansoTableViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/6.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class gansoTableViewController: UITableViewController {

    var GansoData = [gansoData]()
    let GansoAPI = "https://sheetdb.io/api/v1/adu98qbmb9tq6"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: GansoAPI) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let gansoResult = try? decoder.decode([gansoData].self, from: data){
                    
                    self.GansoData = gansoResult
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
        return GansoData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(gansoDataCell.self)", for: indexPath) as! gansoDataCell
        
        let Ganso = GansoData[indexPath.row]
        cell.gansoBrandLabel.text = Ganso.brand
        cell.gansoItemLabel.text = Ganso.itemName
        cell.gansoPriceLabel.text = "\(Ganso.price) 元"
        
        URLSession.shared.dataTask(with: Ganso.photo) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.gansoImageCell.image = UIImage(data: data)
                }
            }
        }.resume()

        return cell
    }
    
    //MARK: - IBSegue to Shopping cart

    @IBSegueAction func GansoDetailSegue(_ coder: NSCoder) -> shoppingcartViewController? {
      
        let destinationController = shoppingcartViewController(coder: coder)
        
        if let row = tableView.indexPathForSelectedRow?.row {
            destinationController?.shopGanso = GansoData[row]
        }
        
        return destinationController
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
