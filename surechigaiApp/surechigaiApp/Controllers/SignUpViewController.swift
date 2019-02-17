//
//  SignUpViewController.swift
//  surechigaiApp
//
//  Created by AIRU ISHIKURA on 2019/02/15.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pushSignUp: UIButton!
    
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self as? UIScrollViewDelegate
        emailTextField.delegate = self as? UITextFieldDelegate
        passwordTextField.delegate = self as? UITextFieldDelegate
        
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // 表示窓のサイズと位置を設定
        scrollView.frame.size = CGSize(width: screenWidth, height: screenHeight)
        
        // UIScrollViewの大きさをスクリーンの縦方向を２倍にする
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight*2)
        
        // スクロールの跳ね返り無し
        scrollView.bounces = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushSignUpButton(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("登録できませんでした\(String(describing: error))")
                self.alert(title: "登録できませんでした", message: "登録できませんでした", okText: "OK")
            }
            if let user = user {
                print(user as Any)
                self.dismiss(animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "toProfileRegistration", sender: nil)
            } else {
                print("登録できませんでした")
                self.alert(title: "登録できませんでした", message: "登録できませんでした", okText: "OK")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,selector: #selector(LoginViewController.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginViewController.keyboardWillHide(_:)) ,
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: self.view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidHideNotification,
                                                  object: self.view.window)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let bottomTextField = pushSignUp.frame.origin.y + pushSignUp.frame.height
        let topKeyboard = screenHeight - keyboardFrame.size.height
        let distance = bottomTextField - topKeyboard
        
        if distance >= 0 {
            scrollView.contentOffset.y = distance + 30.0
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    
    
    func alert(title: String, message: String, okText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        self.present(alert, animated: true, completion: nil)
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
