//
//  ThirdViewController.swift
//  TravelCalcuration2
//
//  Created by jinikuadmin on 2017/03/04.
//  Copyright © 2017年 jinikuadmin. All rights reserved.
//

import UIKit



class ForthViewController: UIViewController, UITableViewDelegate {
    

    @IBOutlet weak var tableView3: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordlist.count //todolist配列の数を取得
    }
    
    
    
    //配列の値をセルにセットし、todoListを表示する
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel!.text = wordlist[indexPath.row]
        
        return cell
        
        
    }
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView3.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
