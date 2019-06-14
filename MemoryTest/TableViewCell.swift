//
//  TableViewCell.swift
//  MemoryTest
//
//  Created by Hanyu on 2019/6/13.
//  Copyright © 2019 Hanyu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var didSelected: (() -> String?)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected, let string = didSelected?() {
            print(string)
        }
    }
    
}
