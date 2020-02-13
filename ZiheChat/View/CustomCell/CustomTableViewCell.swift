//
//  CustomTableViewCell.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var headPortraitImageView: UIImageView!
    @IBOutlet var backView: UIView!
    @IBOutlet var senderUserName: UILabel!
    @IBOutlet var messageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
