//
//  GuardTableViewCell.swift
//  point
//
//  Created by mendy aouizerat  on 26/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
//

import UIKit

class GuardTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
