//
//  CYPreviewTableView.swift
//  CYPreviewTableView
//
//  Created by cyan on 2018/10/16.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit


@objc protocol CYTableviewDataSource : NSObjectProtocol{
    
    @objc func cyPreviewTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc func cyPreviewTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    @objc func registerCell() -> UITableViewCell
    
    // MARK: -  可选
    @objc optional func numberOfSectionsInCYPreviewTableView(tableView: UITableView) -> Int
    @objc optional func cyPreviewTableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String
    @objc optional func cyPreviewTableView(tableView: UITableView, titleForFooterInSection section: Int) -> String

    @objc optional func cyPreviewTableView(tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool
    @objc optional func cyPreviewTableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: IndexPath) -> Bool

    @objc optional func sectionIndexTitlesForCYPreviewTableView(tableView: UITableView) -> Array<String>

    @objc optional func cyPreviewTableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    @objc optional func cyPreviewTableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) -> Void
    
    @objc optional func cyPreviewTableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath) -> Void
    

    
}

class CYPreviewTableView: UITableView, UITableViewDataSource {
    
    ///需要显示预览cell数量 默认显示10个
    var previewCellCount: Int! = 10
    
    ///需要显示占位控件颜色
    var previewCellDefaultColor:UIColor! = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
    
    weak var cyDataSoure: CYTableviewDataSource?
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
}


extension CYPreviewTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:numberOfRowsInSection:))))! {
            if self.cyDataSoure?.cyPreviewTableView(tableView: tableView, numberOfRowsInSection: section) == 0 {
                return self.previewCellCount ?? 10
            }else {
                return (self.cyDataSoure?.cyPreviewTableView(tableView: tableView, numberOfRowsInSection: section))!
            }
        }
        return self.previewCellCount ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:numberOfRowsInSection:))))! && (self.cyDataSoure?.cyPreviewTableView(tableView: tableView, numberOfRowsInSection: indexPath.section) == 0) && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.registerCell)))! {
            let cell = self.cyDataSoure?.registerCell()
            cell?.selectionStyle = .none
            for s in (cell?.contentView.subviews)! {
                if s.isKind(of: UILabel.self){
                    (s as! UILabel).text = " "
                }
                s.backgroundColor = self.previewCellDefaultColor ?? UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
            }
            return cell!
            
        }else {
            if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:cellForRowAtIndexPath:))))! {
                
                let cell = self.cyDataSoure?.cyPreviewTableView(tableView: tableView, cellForRowAtIndexPath: indexPath)
                for s in (cell?.contentView.subviews)! {
                    if s.backgroundColor == UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1) {
                       s.backgroundColor = UIColor.white
                    }
                  
                }
                return cell!
                
            }
        }
        return UITableViewCell.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.numberOfSectionsInCYPreviewTableView(tableView:))))! {
            return (self.cyDataSoure?.numberOfSectionsInCYPreviewTableView!(tableView: tableView))!
        }
        return 1
    }
 

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:titleForHeaderInSection:))))! {
            return self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, titleForHeaderInSection: section)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:titleForFooterInSection:))))! {
            return self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, titleForFooterInSection: section)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:canEditRowAtIndexPath:))))! {
            return (self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, canEditRowAtIndexPath: indexPath))!
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:canMoveRowAtIndexPath:))))! {
            return (self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, canMoveRowAtIndexPath: indexPath))!
        }
        return false
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.sectionIndexTitlesForCYPreviewTableView(tableView:))))! {
            return self.cyDataSoure?.sectionIndexTitlesForCYPreviewTableView!(tableView: tableView)
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:sectionForSectionIndexTitle:atIndex:))))! {
            return (self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, sectionForSectionIndexTitle: title, atIndex: index))!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:commitEditingStyle:forRowAtIndexPath:))))! {
            self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if self.cyDataSoure != nil && (self.cyDataSoure?.responds(to: #selector(CYTableviewDataSource.cyPreviewTableView(tableView:moveRowAtIndexPath:toIndexPath:))))! {
            self.cyDataSoure?.cyPreviewTableView!(tableView: tableView, moveRowAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
        }
    }

}















