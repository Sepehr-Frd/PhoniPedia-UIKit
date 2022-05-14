//
//  SpecialFiltersCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/8/21.
//

import UIKit

class SpecialFiltersCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: RoundedImageView!
    @IBOutlet weak var cellLabel: RoundedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configureCell(specialFilter: SpecialFilters){
        cellImage.image = specialFilter.image
        cellLabel.text = specialFilter.name
    }
    
}
