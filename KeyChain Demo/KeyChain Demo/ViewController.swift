//
//  ViewController.swift
//  KeyChain Demo
//
//  Created by Suraj Bhujbal on 10/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameText:UITextField!
    @IBOutlet weak var PasswordText:UITextField!
    @IBOutlet weak var txtLable:UILabel!
    
    let service = KeychainService.serviceName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController{
    
    // Retrieve password from keychain
    @IBAction func fetchPassword(_ sender:Any){
        if let savedPassword = KeychainManager.getPassword(service: service, account: usernameText.text!) {
            txtLable.text = "Saved password is : \(savedPassword)"
        } else {
            txtLable.text = "Password not found in keychain."
        }
    }
    
    
    // Save password to keychain
    @IBAction func savePassword(_ sender: Any){
        if !usernameText.text!.isEmpty && !PasswordText.text!.isEmpty{
           let save =  KeychainManager.savePassword(service: service, account: usernameText.text!, password: PasswordText.text!)
            txtLable.text = save
        }else{
            txtLable.text = "Enter Username OR Password"
        }
    }
    
    // Delete password from keychain
    @IBAction func deletePassword(_ sender: Any?) {
      let del = KeychainManager.deletePassword(service: service, account: usernameText.text!)
        txtLable.text = del
    }
}
