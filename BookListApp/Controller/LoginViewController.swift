//
//  LoginViewController.swift
//  BookListApp
//
//  Created by 中條航紀 on 2020/05/08.
//  Copyright © 2020 中條航紀. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import DTGradientButton

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        
        //ボタンの背景色を綺麗にする(DTGradientbuttonから）UIColorExtensionないとエラーでる
        loginButton.setGradientBackgroundColors([UIColor(hex:"E21F70"),UIColor(hex:"FF4D2C")], direction: .toBottom, for: .normal)
    }
    
    //returnキーが押された時にとじる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }

    @IBAction func login(_ sender: Any) {
        //もしtextFieldの値がから出ない場合、textfieldの値を自分のアプリ内に保存しておく
        if textField.text?.isEmpty != true{
            UserDefaults.standard.set(textField.text, forKey: "userName")
            
        }else{
            //空ならば振動させる(UIKitに入っている）
            //インスタンスか
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            print("振動")
            
        }
        
        //firebaseAuthの中にIDと名前を入れる
        //クロージャー
        
        Auth.auth().signInAnonymously { (result, error) in
            if error == nil{
                //userなければreturn
                guard let user = result?.user else { return }
                let userID = user.uid
                //自分のアプリ内に保存
                UserDefaults.standard.set(userID, forKey: "userID")
                let saveProfile = SaveProfile(userID: userID, userName: self.textField.text!)
                saveProfile.saveProfile()
                //閉じることで初期画面にいく
                self.dismiss(animated: true, completion: nil)
                
            }else{
                //errorの内容がログに出力される
                print(error?.localizedDescription as Any)
            }
            
        }
    }
    
}
