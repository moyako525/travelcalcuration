//
//  SecondViewController.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/04.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!

    

        @IBAction func additem(_ sender: AnyObject) {
            //todolist配列に入力された文字列を追加
            todolist.append(textfield.text!)
            textfield.text = ""//textfieldをクリアする
            //todolist配列をファイルに保存
            UserDefaults.standard.set(todolist, forKey: "list")
            
            paymentlist.append([textfield2.text!,textfield3.text!])
            
            textfield2.text = ""//textfieldをクリアする
            textfield3.text = ""//textfieldをクリアする
            //paymentlistをファイルに保存
            UserDefaults.standard.set(paymentlist, forKey: "paymentlist")
            
            print(paymentlist)
            
            
            
            

        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textfieldに対するデリゲートの設定
        self.textfield.delegate = self
        self.textfield2.delegate = self
        self.textfield3.delegate = self
        
    }
    
    
    //textfieldをタップすると編集可能に　キーボードが出てくる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    //textfieldでエンターを押すと文字入力のウインドウを非表示にする
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

