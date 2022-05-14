//
//  SpecialFiltersVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/8/21.
//

import UIKit
class SpecialFiltersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables and Constants
    
    var productApi = ProductApi()
    var specialDataObject: SpecialDataObject!
    var productDataObject: ProductDataObject!
    var allProductsArray: [ProductDataObject]!
    var passedTitle: String!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var specialListTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = passedTitle
        specialListTableView.dataSource = self
        specialListTableView.delegate = self
    }
    
    //MARK: - Protocols Methods Implementations
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProductsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = specialListTableView.dequeueReusableCell(withIdentifier: "specialProductCell") as? ProductCell {
            cell.configureCell(brand: allProductsArray[indexPath.row].data.brand, phoneName: allProductsArray[indexPath.row].data.phoneName, image: allProductsArray[indexPath.row].data.thumbnail)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productDataObject = allProductsArray[indexPath.row]
        performSegue(withIdentifier: Segue.fromSpecialToSingleProductVC, sender: self)
    }
    
    
    //MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleProductVC else {return}
        destination.productDataObject = productDataObject
    }
    
}
