//
//  DataSet.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/22/21.
//



//***** Dataset for predefined information ******//


import Foundation
import UIKit

struct DataSet {
    static let brands = [
        Brand(name: "Apple", slug: "apple-phones-48" , image: Images.appleImg),
        Brand(name: "Asus" , slug: "asus-phones-46" ,image: Images.asusImg),
        Brand(name: "BlackBerry" , slug: "blackberry-phones-36" ,image: Images.blackberryImg),
        Brand(name: "Dell" , slug: "dell-phones-61" ,image: Images.dellImg),
        Brand(name: "HP" , slug: "hp-phones-41" ,image: Images.hpImg),
        Brand(name: "HTC" , slug: "htc-phones-45" ,image: Images.htcImg),
        Brand(name: "Huawei" , slug: "huawei-phones-58" ,image: Images.huaweiImg),
        Brand(name: "Lenovo" , slug: "lenovo-phones-73" ,image: Images.lenovoImg),
        Brand(name: "LG" , slug: "lg-phones-20" ,image: Images.lgImg),
        Brand(name: "Microsoft" , slug: "microsoft-phones-64" ,image: Images.microsoftImg),
        Brand(name: "Motorola" , slug: "motorola-phones-4" ,image: Images.motorolaImg),
        Brand(name: "Nokia" , slug: "nokia-phones-1" ,image: Images.nokiaImg),
        Brand(name: "Samsung" , slug: "samsung-phones-9" ,image: Images.samsungImg),
        Brand(name: "Google" , slug: "google-phones-107" ,image: Images.googleImg),
        Brand(name: "Sony" , slug: "sony-phones-7" ,image: Images.sonyImg),
        Brand(name: "Xiaomi" , slug: "xiaomi-phones-80" ,image: Images.xiaomiImg)
    ]
    
    static let specialFilters = [
        SpecialFilters(name: "Latest", slug: "latest", image: Images.latest),
        SpecialFilters(name: "Top by Interest", slug: "top-by-interest", image: Images.topByInterest),
        SpecialFilters(name: "Top by Fans", slug: "top-by-fans", image: Images.topByFans)
    ]
    
}
