//
//  MessageCell.swift
//  MyChats
//
//  Created by 吉本和史 on 2020/10/28.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  
  
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var youImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        contentsView.layer.cornerRadius = contentsView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
