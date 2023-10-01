//
//  TableViewCell.swift
//  Instrument
//
//  Created by Dipendra Dubey on 24/09/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var lblName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
