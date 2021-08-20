//
//  productCell.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import UIKit

class productCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var PriceProduct: UILabel!
    @IBOutlet weak var AddToCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        View.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        View.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        image.layer.cornerRadius = 15.0
        View.layer.cornerRadius = 15
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func reloadImage(image: ProductModelDatumExtra) {
        self.image.kf.indicatorType = .activity
        if let img = URL(string: image.image ?? ""){
            DispatchQueue.main.async {
                self.image.kf.setImage(with: img)
            }
            
        }
    }
    
}
