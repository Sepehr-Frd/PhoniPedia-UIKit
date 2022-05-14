//
//  DetailsDescCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/7/21.
//

import UIKit

class DetailsDescCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(spec: Spec){
        
        nameLabel.text = spec.key
        var finalText = ""
        for item in spec.val {
            
            if item.isEmpty {
                continue
            }
            if item == spec.val.last {
                finalText = "\(finalText)\(item)"
            }
            else {
                finalText = "\(finalText)\(item),"
            }
        }
        descriptionLabel.text = finalText
    }
    
}
