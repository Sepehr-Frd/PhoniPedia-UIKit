//
//  CategoryCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/21/21.
//

import Foundation
import UIKit

class BrandCell: UICollectionViewCell {
    
    @IBOutlet weak var brandImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        brandImg.layer.cornerRadius = 10
        layer.cornerRadius = 10
    }
    
    func configureCell(image: UIImage?){
        guard let image = image else {return}
        brandImg.image = image
    }
    
}
