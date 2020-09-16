//
//  HomePageViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/2.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

   
    @IBOutlet var ContainerView: [UIView]!
    
    
    @IBAction func switchTableView(_ sender: UISegmentedControl) {
        ContainerView.forEach{
            $0.isHidden = true
        }
        ContainerView[sender.selectedSegmentIndex].isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4934554561, blue: 0.5243053216, alpha: 1)
        
    }
    

    /*
     
     for ContainerView in ContainerView {
         ContainerView.isHidden = true
     }
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
