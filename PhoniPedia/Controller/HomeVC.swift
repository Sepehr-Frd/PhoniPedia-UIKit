//
//  ViewController.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/20/21.
//

import UIKit

class HomeVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Variables and Constants
    
    var specialFiltersApi = SpecialFiltersApi()
    var productApi = ProductApi()
    var specialDataObject: SpecialDataObject!
    var productDataObject: ProductDataObject!
    var allProductsArray = [ProductDataObject]()
    var titleToPass: String!
    
    
    
    //MARK: - IBOutlets
    

    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var categoriesBtn: UIButton!
    @IBOutlet weak var specialFiltersCollectionView: UICollectionView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialFiltersCollectionView.delegate = self
        specialFiltersCollectionView.dataSource = self
        title = "Home"
    }
    

    //MARK: - Protocols Methods Implementations
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = specialFiltersCollectionView.dequeueReusableCell(withReuseIdentifier: "specialFiltersCell", for: indexPath) as? SpecialFiltersCell {
            
            cell.configureCell(specialFilter: DataSet.specialFilters[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressIndicator.startAnimating()
        getSpecialProductData(index: indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = view.bounds.width - 20
        let size = CGSize.init(width: dimension, height: 180)
        return size
    }
   

    //MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SpecialFiltersVC else {return}
        destination.productDataObject = productDataObject
        destination.specialDataObject = specialDataObject
        destination.allProductsArray = allProductsArray
        destination.passedTitle = titleToPass
        allProductsArray = [ProductDataObject]()
        
        DispatchQueue.main.async {
            self.progressIndicator.stopAnimating()
        }
    }
    
  
    func getSpecialProductData(index: Int){
        
        self.specialFiltersApi.getSpecialFiltersUrlSession(filterSlug: DataSet.specialFilters[index].slug)
        {[weak self] specialDataObject in
            guard let self = self else {return}
            guard let specialDataObject = specialDataObject else {return}
            self.specialDataObject = specialDataObject
            self.getAllProducts()
        }
        self.titleToPass = DataSet.specialFilters[index].name
    }
    
    func getAllProducts(){
        
        for item in specialDataObject.data.phones {
            let url = item.detail
            productApi.getProductUrlSession(url: url) {[weak self] productDataObject in
                guard let productDataObject = productDataObject,
                      let self = self else {
                          DispatchQueue.main.async {self?.progressIndicator.stopAnimating()}
                          return
                      }
                self.allProductsArray.append(productDataObject)
                if self.allProductsArray.count == self.specialDataObject.data.phones.count {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: Segue.toSpecialFilters, sender: self)
                    }
                }
            }
        }
    }
}

