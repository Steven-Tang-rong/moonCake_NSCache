//
//  ViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/1.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var countText: UITextField!
    
    @IBOutlet weak var passWordText: UITextField!
    
    @IBAction func passButton(_ sender: Any) {
        if countText.text == "123" && passWordText.text == "123"{
            performSegue(withIdentifier: "passSegue", sender: sender)
        }else {
            errorMessage()
        }
    }
    
    func errorMessage() {
        let Alert = UIAlertController(title: "密碼錯誤", message: "請重新輸入", preferredStyle: .alert)
        let Action = UIAlertAction(title: "好", style: .default, handler: nil)
        Alert.addAction(Action)
        present(Alert, animated: true, completion: cleanPassWord)
    }
    
    func cleanPassWord() {
        countText.text = ""
        passWordText.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

