//
//  GetRateController.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/07.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//

import UIKit


class GetRateController : NSObject {
    
    var activity:UIViewController
    var indicator = UIActivityIndicatorView()
    var group = DispatchGroup()
    
    //API上の通貨名(略)
    var countryArray:[String] = ["JPY", "USD", "GBP", "EUR", "CNY", "KRW", "SGD", "AUD", "CAD", "THB"]
    
    //換金レート用配列
    var rateArray:[String: Double] = [String: Double]()
    
    //APIのベースURL ※例：円から他国への換金レート=> http://api.aoikujira.com/kawase/json/JPY
    var baseUrl:String = "http://api.aoikujira.com/kawase/json/"
    
    
    
    init(activity: UIViewController){
        //親アクティビティのインスタンス保持 => グルグル表示
        self.activity = activity
        
        super.init()
    }
    
    
    //実行する関数（APIへアクセス＆配列へ格納）
    func execute(){
        
        //処理中のグルグルを表示
        showIndicator()
        
        //10回APIを叩く
        for i in 0..<countryArray.count {
            group.enter()
            DispatchQueue.global().async {
                self.getRateArray(num: i)
            }
        }
        
        //データ受信＆配列格納が全て完了 => グルグル停止＆レートを内部に保存
        group.notify(queue: .global()) {
            print("レート取得完了")
            //グルグル停止
            self.indicator.stopAnimating()
            
            //本体へ保存
            RateData.sharedInstance.saveRateData(array: self.rateArray)
            
            //debug
            print(self.rateArray)
            print("レコード：\(self.rateArray.count)件")
        }
        
    }
    
    
    //実際にAPIへアクセス＆配列格納を行う
    func getRateArray(num: Int){
        
        let url: URL = URL(string: baseUrl + countryArray[num])!
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { (data, response, error) in
            if error != nil {
                
                print(error!.localizedDescription)
            } else {
                
                
                do {
                    var parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:String]
                    
                    for i in 0..<self.countryArray.count {
                        if(num==i){
                            continue
                        }
                        //各レートを配列rateArrayへ格納
                        self.rateArray[self.countryArray[num]+self.countryArray[i]] = atof(parsedData[self.countryArray[i]])
                    }
                    
                    self.group.leave()
                } catch {
                    //エラー処理
                    self.group.leave()
                }
            }
            
        })
        
        task.resume()
    }
    
    
    
    //グルグル生成＆表示
    func showIndicator() {
        
        // UIActivityIndicatorView のスタイルをテンプレートから選択
        indicator.activityIndicatorViewStyle = .whiteLarge
        // 表示位置
        indicator.center = activity.view.center
        // 色の設定
        indicator.color = UIColor.green
        // アニメーション停止と同時に隠す設定
        indicator.hidesWhenStopped = true
        // 画面に追加
        activity.view.addSubview(indicator)
        // 最前面に移動
        activity.view.bringSubview(toFront: indicator)
        // アニメーション開始
        indicator.startAnimating()
        
    }
    
    
    
}
