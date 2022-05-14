//
//  Constants.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/21/21.
//

import Foundation
import UIKit
import CoreData

struct Images {
    
    //MARK: -Images
    static let mainBackgroundImg = UIImage(named: "Background 1")
    static let launchScreenImg = UIImage(named: "Launch Screen")
    static let topByFans = UIImage(named: "TopByFans")
    static let topByInterest = UIImage(named: "TopByInterest")
    static let latest = UIImage(named: "Latest")
    
    //MARK: -Icon Images
    static let AIOImg = UIImage(named: "AIO")
    static let appleImg = UIImage(named: "Apple")
    static let asusImg = UIImage(named: "Asus")
    static let blackberryImg = UIImage(named: "Blackberry")
    static let dellImg = UIImage(named: "Dell")
    static let hpImg = UIImage(named: "HP")
    static let htcImg = UIImage(named: "HTC")
    static let huaweiImg = UIImage(named: "Huawei")
    static let lenovoImg = UIImage(named: "Lenovo")
    static let lgImg = UIImage(named: "LG")
    static let microsoftImg = UIImage(named: "Microsoft")
    static let mainBackground = UIImage(named: "Background 1")
    static let shoppingBagImg = UIImage(named: "Shopping Bag")
    static let smartphoneImg = UIImage(named: "Smartphone")
    static let motorolaImg = UIImage(named: "Motorola")
    static let nokiaImg = UIImage(named: "Nokia")
    static let samsungImg = UIImage(named: "Samsung")
    static let googleImg = UIImage(named: "Google")
    static let sonyImg = UIImage(named: "Sony")
    static let xiaomiImg = UIImage(named: "Xiaomi")
    static let greenCheck = UIImage(named: "green_check")
    static let redCheck = UIImage(named: "red_check")
}

//MARK: -Colors

struct Colors {
    static let purple = UIColor(red: 103, green: 88, blue: 240, alpha: 0)
    static let grey = CGColor(gray: 1, alpha: 0.65)
    static let green = UIColor(red: 103, green: 222, blue: 68, alpha: 1)
    static let red = UIColor(red: 195, green: 64, blue: 51, alpha: 1)
    static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let white = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
}



//MARK: - Shared Properties
struct SharedProperties {
    

    
    static let BASE_BRAND_URL = "http://api-mobilespecs.azharimm.site/v2/brands/"
    static let BASE_URL = "http://api-mobilespecs.azharimm.site/v2/"
    static let SEARCH_URL = "http://api-mobilespecs.azharimm.site/v2/search?query= "
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}


//MARK: - Storyboard IDs
struct StoryboardId {
    static let loginVC = "loginVC"
    static let profileVC = "profileVC"
    
}

//MARK: - Storyboard Names

struct Storyboard {
    static let main = "Main"
    static let login = "Login"
    static let categories = "Categories"
    static let loginStoryboard = "LoginStoryboard"
}


//MARK: - Segues

struct Segue {
    
    static let toProducts = "toProducts"
    static let toSpecialFilters = "toSpecialFilters"
    static let fromSpecialToSingleProductVC = "fromSpecialToSingleProduct"
    static let fromFavoritesToSingleProductVC = "fromFavoritesToSingleProductVC"
    static let fromSearchToSingleProductVC = "fromSearchToSingleProductVC"
    
} 


//MARK: - Type Aliases

typealias ProductResponseCompletion = (ProductDataObject?) -> Void
typealias BrandResponseCompletion = (BrandDataObject?) -> Void
typealias SpecialFiltersResponseCompletion = (SpecialDataObject?) -> Void
typealias ProductFromSpecialCompletion = (ProductDataObject?) -> Void

