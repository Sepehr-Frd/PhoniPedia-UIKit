//
//  DetailsLabelCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/7/21.
//

import UIKit

class DetailsLabelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    
    func configureCell(title: String?){
        guard let title = title else {
            return
        }
        
        titleLabel.text = title
    }

}
