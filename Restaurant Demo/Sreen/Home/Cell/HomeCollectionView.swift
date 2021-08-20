//
//  HomeCV.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import UIKit
import Kingfisher
class HomeCollectionView: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var footer: UIView!
    @IBOutlet weak var ProductView: CustomeView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.layer.cornerRadius = 15.0
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    func reloadImage(image: Datum) {
        self.image.kf.indicatorType = .activity
        if let img = URL(string: (image.image ?? "") ?? ""){
            DispatchQueue.main.async {
                self.image.kf.setImage(with: img)
                
            }
        }
    }
    
}
