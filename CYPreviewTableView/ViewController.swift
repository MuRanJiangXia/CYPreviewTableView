//
//  ViewController.swift
//  CYPreviewTableView
//
//  Created by cyan on 2018/10/16.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, CYTableviewDataSource {
    
    var cells: Array<String> = []
    
    lazy var table: CYPreviewTableView? = {
        let tableView = CYPreviewTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 400), style: .plain)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(CYTableViewCell.self, forCellReuseIdentifier:"CYTableViewCell")
//        tableView.estimatedRowHeight = 60
        tableView.cyDataSoure = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.table!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadData()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.cells = []
        self.table?.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.loadData()
        }
    }

    func loadData() {
        self.cells = ["我是1","我是2","我是3"] + ["我是1","我是2","我是3"] + ["我是1","我是2","我是3"]
        self.table?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController {
    func cyPreviewTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func cyPreviewTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:CYTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CYTableViewCell", for: indexPath) as! CYTableViewCell
//        var cell = tableView.dequeueReusableCell(withIdentifier: "CYTableViewCell") as? CYTableViewCell
//        if cell == nil {
//            cell = CYTableViewCell.init(style: .default, reuseIdentifier: "CYTableViewCell")
//            cell?.selectionStyle = .none
//        }
        cell.upLoadCell(text: self.cells[indexPath.row])
        return cell
        
    }
    
    func registerCell() -> UITableViewCell {
      return  CYTableViewCell.init(style: .default, reuseIdentifier: "CYTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

