//
//  ShowOrderTableViewCell.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import UIKit
class ShowOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var status4: UIImageView!
    @IBOutlet weak var status3: UIImageView!
    @IBOutlet weak var status2: UIImageView!
    @IBOutlet weak var status1: UIImageView!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var format: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var day_title: UILabel!
    @IBOutlet weak var HomeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        HomeView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        HomeView.layer.cornerRadius = 35.0
        //View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        HomeView.layer.masksToBounds = false
        HomeView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        HomeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        HomeView.layer.shadowOpacity = 0.8
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
    
}
