//
//  Custom1TableViewCell.swift
//  Demo
//
//  Created by cheng on 2018/6/29.
//  Copyright © 2018年 cheng. All rights reserved.
//

import UIKit
import KIVListKit

class Custom1TableViewCell: UITableViewCell,KivListBaseCellProtocol {
    var identifier: NSString = "Custom1TableViewCell"
    
    func updateCell(data: KivBaseItem) {
        self.textLabel?.text = data.data as? String
    }
    
//    static func cellHeight(data:KivBaseItem) -> CGFloat{
//        return 100;
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
