//
//  RegisterViewController.swift
//  TenThings
//
//  Created by Kitty Katt on 7/19/17.
//  Copyright © 2017 kohler. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let userWebServiceURL = "http://127.0.0.1:8000/api/user"

    @IBOutlet weak var nameUITextField: UITextField!
    @IBOutlet weak var emailUITextField: UITextField!
    @IBOutlet weak var passwordUITextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameUITextField.text = "asdfasdf"
        self.emailUITextField.text = "asdfasdf@gmail.com"
        self.passwordUITextField.text = "brassmonkey"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("about to segue")
    }
    
    private func createUser(_ name:String,_ email:String,_ password:String, onSuccess successClosure: @escaping(_ jsonResult:NSDictionary) -> Void, onFailure failureClosure: @escaping(_ jsonResult:NSDictionary) -> Void) -> Void {
        
        let data:String = "name=\(name)&email=\(email)&password=\(password)&password_confirmation=\(password)"
        print("here2")
        HttpRequestHelper.preformBasicPost(to: self.userWebServiceURL, withCallBack: successClosure, sendData: data)
    }
    
    private func registrationFieldsValid() -> Bool {
        return true
    }

    @IBAction func registerUIButtonClick(_ sender: UIButton) {
        let name:String = self.nameUITextField.text ?? ""
        let email:String = self.emailUITextField.text ?? ""
        let password:String = self.passwordUITextField.text ?? ""
        
        let printJson = { (jsonResult:NSDictionary) -> Void in
            print("fetch")
            print("\(jsonResult)")
        }
        
        print("here")
        
        self.createUser(name, email, password, onSuccess: printJson, onFailure: printJson)
    }


}
