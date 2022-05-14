//
//  ProductsVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/22/21.
//

import UIKit
import Foundation

class ProductsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables and Constants
    
    var productApi = ProductApi()
    var dataObject: BrandDataObject!
    var brandPhonesArray: [Phone]!
    var productDataObject: ProductDataObject!
    var selectedProductSlug: String!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var activityIndicator: RoundedActivityIndicator!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        productsTableView.delegate = self
        productsTableView.dataSource = self
        title = dataObject.data.title.replacingOccurrences(of: " phones", with: "")
    }
    
    //MARK: - Protocol Methods Implementations
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataObject.data.phones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = productsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductCell {
            cell.configureCell(brand: brandPhonesArray[indexPath.row].brand.replacingOccurrences(of: " ", with: ""), phoneName: brandPhonesArray[indexPath.row].name, image: brandPhonesArray[indexPath.row].image)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        selectedProductSlug = brandPhonesArray[indexPath.row].slug
        getProductObject()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    //MARK: - Methods
    
    func getProductObject() {
        guard let slug = selectedProductSlug else {
            activityIndicator.stopAnimating()
            return
        }
        productApi.getProductUrlSession(url: "\(SharedProperties.BASE_URL)\(slug)") {[weak self] productDataObject in
            guard let productDataObject = productDataObject,
                  let self = self else {
                      self?.activityIndicator.stopAnimating()
                      return
                  }
            self.productDataObject = productDataObject
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toSingleProduct", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleProductVC else {return}
        destination.productDataObject = productDataObject
        activityIndicator.stopAnimating()
    }
    
}
