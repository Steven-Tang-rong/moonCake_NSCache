//
//  ViewController.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/1.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var countText: UITextField! {
        didSet{
            countText.tag = 1
            countText.delegate = self
        }
    }
    
    @IBOutlet weak var passWordText: UITextField! {
        didSet{
            passWordText.tag = 2
            passWordText.delegate = self
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: Any) {
    }
    
    @IBAction func passButton(_ sender: Any) {
        if countText.text == "941" && passWordText.text == "941"{
            performSegue(withIdentifier: "passSegue", sender: sender)
        }else {
            errorMessage()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

