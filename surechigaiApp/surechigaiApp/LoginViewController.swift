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

// ToDo: ログインの可否はアラートで表示させたい

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var pushLogin: UIButton!
    
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self as? UIScrollViewDelegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
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
                
                self.performSegue(withIdentifier: "toHome", sender: nil)
            } else {
                print("登録できませんでした")
                self.alert(title: "登録できませんでした", message: "登録できませんでした", okText: "OK")
            }
        }
    }
    
    @IBAction func pushLoginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error != nil {
                print("ログインできませんでした")
                self.alert(title: "ログインできませんでした", message: "ログインできませんでした", okText: "OK")
            }
            if user != nil {
                self.dismiss(animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "toHome", sender: nil)
            } else {
                print("ログインできませんでした")
                self.alert(title: "ログインできませんでした", message: "ログインできませんでした", okText: "OK")
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
        
        let bottomTextField = pushLogin.frame.origin.y + pushLogin.frame.height
        let topKeyboard = screenHeight - keyboardFrame.size.height
        let distance = bottomTextField - topKeyboard
        
        if distance >= 0 {
            scrollView.contentOffset.y = distance + 30.0
        }
        
        //        調整用
        //        print("hyouji bottomTextField : \(bottomTextField)")
        //        print("hyouji pushLogin.frame.origin.y : \(pushLogin.frame.origin.y)")
        //        print("hyouji pushLogin.frame.height : \(pushLogin.frame.height)")
        //        print("hyouji topKeyboard : \(topKeyboard)")
        //        print("hyouji screenHeight : \(String(describing: screenHeight))")
        //        print("hyouji keyboardFrame.size.height : \(keyboardFrame.size.height)")
        //        print("hyouji distance : \(distance)")
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset.y = 0
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
}
