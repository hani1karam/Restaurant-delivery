//
//  CartTableViewCell.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/16/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imge: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var priceCart: UILabel!
    @IBOutlet weak var HomeView: UIView!
    @IBOutlet weak var Delet: UIButton!
    @IBOutlet weak var priceoffer: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        HomeView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        imge.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(compines: Item) {
        
        if let img = URL(string: compines.image ?? ""){
            DispatchQueue.main.async {
                self.imge.kf.indicatorType = .activity
                self.imge.kf.setImage(with: img)
                
            }
        }
    }

}
