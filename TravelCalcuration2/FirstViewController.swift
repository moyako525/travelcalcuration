//
//  FirstViewController.swift
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


class FirstViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        

        paymentlist = []
        todolist = []
        resultlist1 = []
        resultlist2 = []
        
        
        //todolistをファイルに保存
        //
        UserDefaults.standard.set(todolist, forKey: "list")
        
        //paymentlistをファイルに保存
        //
        UserDefaults.standard.set(paymentlist, forKey: "paymentlist")
        
        //resultlist1をファイルに保存
        //
        UserDefaults.standard.set(resultlist1, forKey: "resultlist1")
        
        //resultlist2をファイルに保存
        //
        UserDefaults.standard.set(resultlist2, forKey: "resultlist2")
        
        
        print(todolist.count)
        print(todolist)
        print(paymentlist)
        print(resultlist1)
        print(resultlist2)
        
        
    }
    
    //セクション毎の数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count //todolist配列の数を取得
    }
    
    //配列の値をセルにセットし、todoListを表示する
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")//せるのidentifierを指定
        cell.textLabel?.text = todolist[indexPath.row]//todolist配列の中身をセルにセット
        return cell
    }
    
    
    
    //選択したセルのtodolistを削除する
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath){
        //セルを選択し、Deleteが選択された場合
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            
            if paymentlist.count == 0 {
                resultlist1 = []
                resultlist2 = []
                
                UserDefaults.standard.set(resultlist1, forKey: "resultlist1")//配列をファイルに上書き
                UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
            
            } else if paymentlist.count >= 1 {
                
                let arrayNum = resultlist1.index(of: paymentlist[indexPath.row][0])
                
                if arrayNum == nil {
                    
                }else if arrayNum != nil {
                    
                    resultlist2[arrayNum!] = String(Double(resultlist2[arrayNum!])! - Double(paymentlist[indexPath.row][1])!)

                    UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
                    
                    if resultlist2[arrayNum!] == "0" {
                        
                        resultlist2.remove(at: arrayNum!)
                        resultlist1.remove(at: arrayNum!)
                        
                        UserDefaults.standard.set(resultlist1, forKey: "resultlist1")//配列をファイルに上書き
                        UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
                    }
                    
                    else {
                        
                        UserDefaults.standard.set(resultlist1, forKey: "resultlist1")//配列をファイルに上書き
                        UserDefaults.standard.set(resultlist2, forKey: "resultlist2")//配列をファイルに上書き
                        
                    }
                    
                    
                }
                
            }
            
            todolist.remove(at: indexPath.row)//選択した番号で配列から削除
            paymentlist.remove(at: indexPath.row)
            UserDefaults.standard.set(todolist, forKey: "list")//削除された配列をファイルに上書き
            UserDefaults.standard.set(paymentlist, forKey: "paymentlist")//削除された配列をファイルに上書き
            tableView.reloadData()//tableViewの再表示

            print("Delete")
            print(todolist)
            print(paymentlist)
            print(resultlist1)
            print(resultlist2)
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

