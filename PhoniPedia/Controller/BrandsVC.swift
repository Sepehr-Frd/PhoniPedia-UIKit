//
//  CategoriesVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/21/21.
//

import UIKit

class BrandsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //MARK: - Variables and Constants

    var dataObject: BrandDataObject!
    var brandApi = BrandApi()
    var selectedBrandName: String!
    
    //MARK: - IBOutlets
    @IBOutlet weak var BrandsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: RoundedActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BrandsCollectionView.delegate = self
        BrandsCollectionView.dataSource = self
        title = "Brands"
    }
    
    // MARK: - Protocol Methods Implementations
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let cellDimension = (width / 2.5)
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as? BrandCell else {return UICollectionViewCell()}
        
        cell.configureCell(image: DataSet.brands[indexPath.item].image)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        selectedBrandName = DataSet.brands[indexPath.item].slug
        getDataObject(brandName: selectedBrandName)
        
    }
    
    //MARK: - Methods
    
    func getDataObject(brandName: String){
        brandApi.getBrandUrlSession(brandName: brandName){[weak self] dataObjectPassed in
            guard let dataObjectPassed = dataObjectPassed,
                  let self = self else {
                      self?.activityIndicator.stopAnimating()
                      return
                  }
            self.dataObject = dataObjectPassed
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Segue.toProducts, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ProductsVC else {return}
        destination.brandPhonesArray = dataObject.data.phones
        destination.dataObject = dataObject
        activityIndicator.stopAnimating()
    }
    
}
