//
//  Custom UI Elements Classes.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/20/21.
//


//Customized UI elements


import Foundation
import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
}

class RoundedLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
}

class RoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        
        
    }
}

class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        
        
    }
}

class CircledImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = layer.frame.size.width / 2
    }
    
}

class RoundedCollectionView: UICollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
}

class RoundedActivityIndicator: UIActivityIndicatorView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
}
