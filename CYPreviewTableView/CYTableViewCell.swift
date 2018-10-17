//
//  CYTableViewCell.swift
//  CYPreviewTableView
//
//  Created by cyan on 2018/10/17.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class CYTableViewCell: UITableViewCell {

    var titleLab: UILabel!
    var imageV: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func createUI() {
        
        let label = UILabel(frame: CGRect(x: 40, y: 10, width: 100, height: 40))
        label.backgroundColor = UIColor.red
        label.text = "text"
        label.textColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(label)
        titleLab = label
        
        
        let imageView  = UIImageView(frame: CGRect(x: 160, y: 10, width: 40, height: 40))
        imageView.backgroundColor = UIColor.yellow
        self.contentView.addSubview(imageView)
        imageV = imageView
    }

    
    func upLoadCell(text: String) {
        titleLab.text = text
        titleLab.backgroundColor = UIColor.red
    }
    
}
