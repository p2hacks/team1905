//
//  LoginViewController.swift
//  surechigaiApp
//
//  Created by 前田陸 on 2019/02/10.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushSignUpButton(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("登録できませんでした\(String(describing: error))")
            }
            if let user = user {
                print(user as Any)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("登録できませんでした")
            }
        }
    }
    
    @IBAction func pushLoginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error != nil {
                print("サインインできませんでした")
            }
            if user != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("サインインできませんでした")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
