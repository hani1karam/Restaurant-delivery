//
//  SizeTableViewCell.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import UIKit

class SizeTableViewCell: UITableViewCell {
    @IBOutlet weak var pricee: UILabel!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
