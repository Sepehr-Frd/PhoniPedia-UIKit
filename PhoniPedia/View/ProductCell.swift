//
//  ProductTableCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/27/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }

    func getImageFromUrl(url: String){
        
            guard let imageUrl = URL(string: url) else {return}
            let imageData = NSData(contentsOf: imageUrl)
            let image = UIImage(data: imageData as Data? ?? Data())
            DispatchQueue.main.async {
                self.productImg.image = image
                
        }
    }
    
    func configureCell(brand: String?, phoneName: String?, image: String?){
        guard let phoneName = phoneName,
              let brand = brand,
              let image = image else {return}
        productName.text = "\(brand) \(phoneName)"
        
        DispatchQueue.global(qos: .background).async {
                self.getImageFromUrl(url: image)
        }
    }
    
}
