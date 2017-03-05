//
//  ThirdViewController.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/04.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//

import UIKit



class ThirdViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView2: UITableView!
    

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultlist1.count //todolist配列の数を取得
    }
    
    
    
    //配列の値をセルにセットし、todoListを表示する
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")//せるのidentifierを指定
        //cell.textLabel?.text = resultlist1[indexPath.row]//todolist配列の中身をセルにセット
        cell.textLabel!.text = resultlist1[indexPath.row]
        cell.detailTextLabel?.text = resultlist2[indexPath.row]
        return cell

    }
    


    

    
    override func viewDidAppear(_ animated: Bool) {
        tableView2.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
