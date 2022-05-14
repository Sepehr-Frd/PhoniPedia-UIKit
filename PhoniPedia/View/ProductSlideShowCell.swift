//
//  ProductSlideShowCell.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/5/21.
//

import UIKit

class ProductSlideShowCell: UICollectionViewCell {

    @IBOutlet weak var cellImg: UIImageView!
    
    func configureCell(imageName: String?){
        guard let imageName = imageName else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            guard let imageUrl = URL(string: imageName) else {return}
            let imageData = NSData(contentsOf: imageUrl)
            let image = UIImage(data: imageData as Data? ?? Data())
            DispatchQueue.main.async {
                self.cellImg.image = image
           }
    }
}

}
