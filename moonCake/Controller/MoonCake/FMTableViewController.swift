//
//  FMTableViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/5.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class FMTableViewController: UITableViewController {

    var fmStationData = [FMStationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FmCacheController.shared.fetchFMImage { [weak self] (fmStationData) in
           guard let self = self else { return }
            if let fmStationData = fmStationData {
                self.fmStationData = fmStationData
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
        return fmStationData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FMdataCell.self)", for: indexPath) as! FMdataCell

        let FM = fmStationData[indexPath.row]
        cell.update(with: FM)
        
        
        return cell
    }
    
 //MARK: - IBSegue to Shopping cart
    
    @IBSegueAction func FMDetailSegue(_ coder: NSCoder) -> shoppingcartViewController? {
       
        let destinationController = shoppingcartViewController(coder: coder)

        if let row = tableView.indexPathForSelectedRow?.row {
            
            destinationController?.shopFM = fmStationData[row]
            
            
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
