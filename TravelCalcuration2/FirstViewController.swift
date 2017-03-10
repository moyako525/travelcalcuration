//
//  SecondViewController.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/04.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//

import UIKit

//todolistを記憶しておく配列　他のViewControllerから使えるようグローバルで宣言
var todolist = [String]()
var paymentlist = [[String]]()
var resultlist1 = [String]()
var resultlist2 = [String]()
var resultlist3 = [String]()
var resultlist4 = [Int]()
var resultlist5 = [String]()
var resultlist6 = [Int]()
var wordlist = [String]()
var DoubleResultlist2 = [Double]()


class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var pickerview1: UIPickerView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    
    
    var data3:String = ""
    var data4:String = ""
    var data5:String = ""
    var rateNum: Double = 0
    
    
    let dataList:[[String]] = [["円", "元", "ドル", "ユーロ", "ポンド", "カナダドル", "ｵｰｽﾄﾗﾘｱﾄﾞﾙ", "ｼﾝｶﾞﾎﾟｰﾙﾄﾞﾙ", "バーツ"], ["円", "元", "ドル", "ユーロ", "ポンド", "カナダドル", "ｵｰｽﾄﾗﾘｱﾄﾞﾙ", "ｼﾝｶﾞﾎﾟｰﾙﾄﾞﾙ", "バーツ"]]
    
    
    override func viewDidLoad() {
        
        //ファイルに保存されているtodoListを読み込む
        //消えてもいいようにファイルに保存　起動する際に保存から読み込んで配列に反映
        //NSUserDefaultsはファイルから読み込む際に使う　リストというキーで読み込む
        if UserDefaults.standard.object(forKey: "list") != nil {
            todolist = UserDefaults.standard.object(forKey: "list") as! [String]
            
        }
        
        if UserDefaults.standard.object(forKey: "paymentlist") != nil {
            paymentlist = UserDefaults.standard.object(forKey: "paymentlist") as! [[String]]
            
        }
        
        if UserDefaults.standard.object(forKey: "resultlist1") != nil {
            resultlist1 = UserDefaults.standard.object(forKey: "resultlist1") as! [String]
            
        }
        
        if UserDefaults.standard.object(forKey: "resultlist2") != nil {
            resultlist2 = UserDefaults.standard.object(forKey: "resultlist2") as! [String]
            
        }
        
        
        
        
        //paymentlist = []
        //todolist = []
        //resultlist1 = []
        //resultlist2 = []
        
        
        //todolistをファイルに保存
        //UserDefaults.standard.set(todolist, forKey: "list")
        
        //paymentlistをファイルに保存
        //UserDefaults.standard.set(paymentlist, forKey: "paymentlist")
        
        //resultlist1をファイルに保存
        //UserDefaults.standard.set(resultlist1, forKey: "resultlist1")
        
        //resultlist2をファイルに保存
        //UserDefaults.standard.set(resultlist2, forKey: "resultlist2")
        
        
        print(todolist.count)
        print(todolist)
        print(paymentlist)
        print(resultlist1)
        print(resultlist2)
        
        
        
        
        
        super.viewDidLoad()
        
        //textfieldに対するデリゲートの設定
        self.textfield.delegate = self
        self.textfield2.delegate = self
        self.textfield3.delegate = self
        
        btn1.tag = 0
        btn1.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
        
        btn2.tag = 1
        btn2.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
        
        
        
        //-------------------------------
        // 初回起動時 or 本体にレート情報が無いかどうか判定　TRUE => レートを新たに受信する
        //-------------------------------
        if(RateData.sharedInstance.isFirstStart()) {
            //初回起動 or 本体にレート情報が無い
            
            //-------------------------------
            // 通貨レート取得時にこの２行を追加する
            //-------------------------------
            let get = GetRateController(activity: self)
            get.execute()
            
        }else{
            //２回目以降は、既に本体に保存されているレート情報を読み込む
            RateData.sharedInstance.loadRateData()
        }
        
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
    
    //コンポーネントの個数を返すメソッド
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return dataList.count
    }
    
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList[component].count
    }
    
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[component][row]
    }
    
    
    //データ選択時の呼び出しメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //コンポーネントごとに現在選択されているデータを取得する。
        let data1 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
        
        let data2 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)
        
        switch "\(data1!)"{
            //　"JPY":日本円, "USD":ドル, "GBP":英国ポンド, "EUR":ユーロ, "CNY":中国(元),
        //  "KRW":韓国(ウォン), "SGD":シンガポールドル, "AUD":豪ドル, "CAD":カナダドル, "THB":タイ(バーツ)
        case "円":
            data3 = "JPY"
            
        case "元":
            data3 = "CNY"
            
        case "ドル":
            data3 = "USD"
            
        case "ユーロ":
            data3 = "EUR"
            
        case "ポンド":
            data3 = "GBP"
            
        case "カナダドル":
            data3 = "CAD"
            
        case "オーストラリアドル":
            data3 = "AUD"
            
        case "シンガポールドル":
            data3 = "SGD"
            
        case "バーツ":
            data3 = "THB"
            
        default:
            break
        }
        
        switch "\(data2!)"{
            
        case "円":
            data4 = "JPY"
            
        case "元":
            data4 = "CNY"
            
        case "ドル":
            data4 = "USD"
            
        case "ユーロ":
            data4 = "EUR"
            
        case "ポンド":
            data4 = "GBP"
            
        case "カナダドル":
            data4 = "CAD"
            
        case "オーストラリアドル":
            data4 = "AUD"
            
        case "シンガポールドル":
            data4 = "SGD"
            
        case "バーツ":
            data4 = "THB"
            
        default:
            break
        }
        
        data5 = "\(data3)\(data4)"
        
    }
    
    
    
    
    @IBAction func additem(_ sender: AnyObject) {
        
        rateNum = RateData.sharedInstance.rateArray["\(data5)"]!
        print(data5)
        
        //todolist配列に入力された文字列を追加
        todolist.append(textfield.text!)
        textfield.text = ""//textfieldをクリアする
        //todolist配列をファイルに保存
        UserDefaults.standard.set(todolist, forKey: "list")
        
        let num = String(Double(textfield3.text!)! * rateNum)
        
        paymentlist.append([textfield2.text!,num])
        
        textfield2.text = ""//textfieldをクリアする
        textfield3.text = ""//textfieldをクリアする
        //paymentlistをファイルに保存
        UserDefaults.standard.set(paymentlist, forKey: "paymentlist")
        
        
        if paymentlist.count == 1 {
            
            resultlist1.append(paymentlist[0][0])
            resultlist2.append(paymentlist[0][1])
            
            UserDefaults.standard.set(resultlist1, forKey: "resultlist1")//配列をファイルに上書き
            UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
            
            
        } else if paymentlist.count >= 2 {
            
            let n :Int = paymentlist.count
            
            let arrayNum = resultlist1.index(of: paymentlist[n-1][0])
            
            if arrayNum == nil {
                
                resultlist1.append(paymentlist[n-1][0])
                resultlist2.append(paymentlist[n-1][1])
                
                UserDefaults.standard.set(resultlist1, forKey: "resultlist1")//配列をファイルに上書き
                UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
                
            }else if arrayNum != nil {
                
                let num: Double = Double(resultlist2[Int(arrayNum!)])! + Double(paymentlist[n-1][1])!
                resultlist2[arrayNum!]  = String(num)
                
                UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
                
            }
            
            for n in 0...resultlist2.count-1 {
                DoubleResultlist2.append(Double(resultlist2[n])!)
            }
            
            let sum = DoubleResultlist2.reduce(0, +)
            
            let num2 = sum/(Double(resultlist2.count))
            
            for _ in 0...((DoubleResultlist2.count)-1){
                
                let numMax = DoubleResultlist2.max()
                
                let max1 = DoubleResultlist2.index(of: numMax!)
                
                resultlist3.append(resultlist1[max1!])
                
                resultlist4.append(Int(DoubleResultlist2[max1!]))
                
                DoubleResultlist2.remove(at: max1!)
                
                
            }
            
            
            if resultlist4.count == 1 {
                
            } else if resultlist4.count == 2 {
                let num3 = resultlist4[0] - resultlist4[1]
                let word = "\(resultlist3[0])は\(resultlist3[1])に\(num3)円もらう"
                wordlist.append(word)
                
            } else if resultlist4.count >= 3{
                
                for a in 0...((resultlist4.count)-1) {
                    
                    if  resultlist4[a] > Int(num2) {
                        resultlist6.append(resultlist4[a])
                        resultlist5.append(resultlist3[a])
                        
                    }}
                for _ in 1...resultlist6.count{
                    resultlist4.removeFirst()
                    resultlist3.removeFirst()
                    
                }
                
                if resultlist6.count == 0 {
                    
                } else if resultlist6.count >= 1{
                    
                    for a in 0...(resultlist6.count-1){
                        var num3 = resultlist6[a]-Int(num2)
                        let num4 = Int(num2)-resultlist4[a]
                        while num3 >= 0{
                            
                            if num3 < num4 {
                                
                                let word = "\(resultlist5[a])は\(resultlist3[a])に\(num3)円もらう"
                                wordlist.append(word)
                                
                                
                            } else if num3 > num4 {
                                
                                let word = "\(resultlist5[a])は\(resultlist3[a])に\(num4)円もらう"
                                num3 = num3-num4
                                wordlist.append(word)
                            }
                        }
                    }
                }
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        print("Add")
        print(todolist)
        print(paymentlist)
        print(resultlist1)
        print(resultlist2)
        print(DoubleResultlist2)
        
    }
    
    
    @IBAction func tapped(_ sender: UIButton) {
        
        let get = GetRateController(activity: self)
        get.execute()
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

