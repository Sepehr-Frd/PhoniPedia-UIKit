//
//  Extensions.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/2/21.
//

import Foundation
import UIKit

extension String {
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
}

extension UICollectionView {
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath
        }
        return nil
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
