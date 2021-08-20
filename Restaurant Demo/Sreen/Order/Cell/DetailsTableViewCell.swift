//
//  DetailsTableViewCell.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import Foundation
import Kingfisher
class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Number: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var HomeView: CustomeView!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var extra: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        HomeView.backgroundColor = UIColor.white
        HomeView.backgroundColor = UIColor.white
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        HomeView.layer.cornerRadius = 35.0
        img.layer.cornerRadius = 15.0
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]


    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(compines: ShowDetilaModelProduct)
    {
        
        if let img = URL(string: compines.image ?? ""){
            self.img.kf.indicatorType = .activity
            self.img.kf.setImage(with: img)
            
        }
    }
    
    
}
