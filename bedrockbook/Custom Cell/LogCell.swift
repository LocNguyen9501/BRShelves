//
//  LogCell.swift
//  bedrockbook
//
//  Created by QUANG on 7/27/18.
//  Copyright © 2018 Nguyenxloc. All rights reserved.
//

import UIKit
import MarqueeLabel

class LogCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var lblTitle: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
