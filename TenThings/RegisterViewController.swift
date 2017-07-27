//
//  RegisterViewController.swift
//  TenThings
//
//  Created by Kitty Katt on 7/19/17.
//  Copyright © 2017 kohler. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let userWebServiceURL = "http://127.0.0.1:8000/api/user"

    @IBOutlet weak var nameUITextField: UITextField!
    @IBOutlet weak var emailUITextField: UITextField!
    @IBOutlet weak var passwordUITextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameUITextField.delegate = self
        self.emailUITextField.delegate = self
        self.passwordUITextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("about to segue")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return textField.resignFirstResponder()
    }
    
    private func createUser(_ name:String,_ email:String,_ password:String, onSuccess successClosure: @escaping(_ httpUrlResponse:HTTPURLResponse?, _ jsonResult:NSDictionary?) -> Void, onFailure failureClosure: @escaping(_ error:NSError) -> Void) -> Void {
        
        let data:String = "name=\(name)&email=\(email)&password=\(password)&password_confirmation=\(password)"
        HttpRequestHelper.preformBasicPost(to: self.userWebServiceURL, withCallBack: successClosure, sendData: data, withErrorHandler: failureClosure)
    }
    
    private func registrationFieldsValid() -> Bool {
        return true
    }

    @IBAction func registerUIButtonClick(_ sender: UIButton) {
        let name:String = self.nameUITextField.text ?? ""
        let email:String = self.emailUITextField.text ?? ""
        let password:String = self.passwordUITextField.text ?? ""
        
        let handleSuccess = { (_ httpUrlResponse:HTTPURLResponse?, _ jsonResult:NSDictionary?) -> Void in
            
            switch httpUrlResponse!.statusCode {
            case 200:
                print("Success!")
                print("\(jsonResult!)")
            default:
                print("Error")
                print("\(jsonResult!)")
            }
        }
        
        let handleFailure = { (_ error:NSError) -> Void in
            print("Something really bad happened: \(error.localizedDescription)")
        }
        
        self.createUser(name, email, password, onSuccess: handleSuccess, onFailure: handleFailure)
    }


}
