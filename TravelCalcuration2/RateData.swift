//
//  RateData.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/07.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//
//　■説明
//  このシングルトンクラスにレート情報(rateArray)を統一してもつ
//　どのクラスからでも、RateData.sharedInstance.rateArray["キー名"]でレートの数値を呼び出し可能
//　キー名は、円=>ドルの場合は「JPYUSD」
//          ユーロ=>バーツの場合は「EURTHB」など、変換前の通貨名(略)＋変換後の通貨名(略)で作る
//
//　■使い方(例)
//　・100ユーロをバーツに変換する場合
//      バーツ = 100 * RateData.sharedInstance.rateArray["EURTHB"]
//  ・逆パターン
//      ユーロ = 100 * RateData.sharedInstance.rateArray["THBEUR"]
//
//　■通貨名(略)  現在、以下の10種類の相互変換が可能　※通貨名はAPI上の名前と合わせている
//　"JPY":日本円, "USD":ドル, "GBP":英国ポンド, "EUR":ユーロ, "CNY":中国(元),
//  "KRW":韓国(ウォン), "SGD":シンガポールドル, "AUD":豪ドル, "CAD":カナダドル, "THB":タイ(バーツ)
//



import Foundation


class RateData :NSObject {
    
    //シングルトン化
    static let sharedInstance = RateData()
    
    //本体保存領域へアクセス
    var userDefaults = UserDefaults.standard
    
    //レート情報用配列
    var rateArray:[String: Double] = [String: Double]()
    
    //削除禁止
    private override init() {
        
    }
    
    //初回起動かどうか or レート情報を持っているか判定
    func isFirstStart() -> Bool{
        
        if (userDefaults.object(forKey: "rateArray") == nil) {
            return true
        }else{
            return false
        }
    }
    
    //本体に保存されているレート情報を読み込み
    func loadRateData() {
        
        let storedData = userDefaults.object(forKey: "rateArray") as! Data
        self.rateArray = NSKeyedUnarchiver.unarchiveObject(with: storedData) as! [String:Double]
        
        print("Loaded RateData")
    }
    
    
    //レート情報を本体に保存
    func saveRateData(array:[String:Double]) {
        
        self.rateArray = array
        
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: self.rateArray)
        userDefaults.set(archiveData, forKey: "rateArray")
        userDefaults.synchronize()
        print("Saved RateData")
    }
    
    
    
    //レート情報を削除
    func deleteRateData() {
        
        rateArray = [String: Double]()
        userDefaults.removeObject(forKey: "rateArray")
        userDefaults.synchronize()
        print("Deleted RateData")
    }
    
    
}

