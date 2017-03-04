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
        
        print(todolist)
        print(paymentlist)

        
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
            todolist.remove(at: indexPath.row)//選択した番号で配列から削除
            //paymentlist.remove(at: indexPath.row)
            UserDefaults.standard.set(todolist, forKey: "list")//削除された配列をファイルに上書き
            //UserDefaults.standard.set(paymentlist, forKey: "list")//削除された配列をファイルに上書き
            tableView.reloadData()//tableViewの再表示
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

