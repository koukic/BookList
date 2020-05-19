//
//  SearchViewController.swift
//  BookListApp
//
//  Created by 中條航紀 on 2020/05/11.
//  Copyright © 2020 中條航紀. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON
import DTGradientButton
import Firebase
import FirebaseAuth
import ChameleonFramework

class SearchViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    
    //apiに合わせて型を作る
    var bookNameArray = [String]()
    var imageStringArray = [String]()
    var userID = String()
    var userName = String()
    var autoID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "autoID") != nil{
            autoID = UserDefaults.standard.object(forKey: "autoID") as! String
            print(autoID)
        }else{
            //ログインがされていない時は新規登録画面に飛ばす
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            //表示
            self.present(loginVC, animated: true, completion: nil)
        }
        
        if UserDefaults.standard.object(forKey: "userID") != nil && UserDefaults.standard.object(forKey: "userName") != nil{
            
            userID = UserDefaults.standard.object(forKey: "userID") as! String
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        searchTextField.delegate = self
        //キーボード出す
        searchTextField.becomeFirstResponder()
        
        favButton.setGradientBackgroundColors([UIColor(hex:"E21F70"),UIColor(hex:"FF4D2C")], direction: .toBottom, for: .normal)
            
        listButton.setGradientBackgroundColors([UIColor(hex:"FF8960"),UIColor(hex:"FF62A5")], direction: .toBottom, for: .normal)

        
    }
    
    //viewdidloadの次に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //バーの色
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.flatRed()
        //ナビゲーションバーのBackButtonを消す
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
    }
    
    //リターンキーが押されたら閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    //タッチでも閉じる
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    
    @IBAction func moveToSelectCardView(_ sender: Any) {
        
        //パースを行う
    }
    
    //画面遷移
    func moveToCard() {
        performSegue(withIdentifier: "selectVC", sender: nil)
    }
    
    func startParse(keyword:String){
        HUD.show(.progress)
        //初期化しないと毎回配列に入るのでエラーが起きる
        
    }
    

}
