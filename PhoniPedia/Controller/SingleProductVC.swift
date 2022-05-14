//
//  SingleProductVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/22/21.
//

import UIKit

class SingleProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Variables and Constants
    
    let context = (SharedProperties.context)!
    var productDataObject: ProductDataObject!
    var favorites: [SavedProductDataObject]?
    var allElementsToPass = [Any]()
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addToFavoritesButton: RoundedButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        title = "\(productDataObject.data.brand) \(productDataObject.data.phoneName)"
        pageControl.numberOfPages = productDataObject.data.phoneImages.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        getAllElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchFavorites()
        if isInFavorites() {
            DispatchQueue.main.async {
                self.setForRemoveBtn()
            }
        } else {
            DispatchQueue.main.async {
                self.setForAddBtn()
            }
        }
    }
    
    //MARK: - Protocols Methods Implementaions
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: slideShowCollectionView.bounds.width, height: slideShowCollectionView.bounds.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDataObject.data.phoneImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slideShowCell", for: indexPath) as? ProductSlideShowCell else {return UICollectionViewCell()}
        cell.configureCell(imageName: productDataObject.data.phoneImages[indexPath.item])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let currentCell = slideShowCollectionView.visibleCurrentCellIndexPath?.item else {return}
        pageControl.currentPage = currentCell
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addToFavoritesClicked(_ sender: Any) {
        
        if isInFavorites() {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
        
    }
    
    
    //MARK: - Methods
    
    @objc private func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        let pageNumber = IndexPath.init(item: current , section: 0)
        slideShowCollectionView.scrollToItem(at: pageNumber , at: .centeredHorizontally, animated: true)
        
    }
    
    func fetchFavorites(){
        do {
            favorites = try context.fetch(SavedProductDataObject.fetchRequest())
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func addToFavorites(){
        
        let favorite = SavedProductDataObject(context: context)
        favorite.phoneName = productDataObject.data.phoneName
        favorite.phoneImage = productDataObject.data.thumbnail
        favorite.brandName = productDataObject.data.brand
        
        do {
            try context.save()
            print("Successfully saved the favorite to core data")
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        let alert = UIAlertController(title: "Done!", message: "Successfully added to favorites", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay!", style: .cancel){_ in }
        alert.addAction(alertAction)
        self.present(alert, animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
        
        fetchFavorites()
        
        DispatchQueue.main.async {
            self.setForRemoveBtn()
        }
    }
    
    func removeFromFavorites(){
        guard let sharedFavorites = favorites else {
            return
        }
        var count = 0
        for item in sharedFavorites {
            if item.phoneName == productDataObject.data.phoneName {
                break
            } else {
                count += 1
            }
        }
        let favoriteToRemove = sharedFavorites[count]
        
        context.delete(favoriteToRemove)
        do {
            try context.save()
            print("successfully deleted")
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        fetchFavorites()
        DispatchQueue.main.async {
            self.setForAddBtn()
        }
    }
    
    func isInFavorites() -> Bool {
        guard let sharedFavorites = favorites else {
            return false
        }
        
        var count = 0
        for item in sharedFavorites {
            
            if item.phoneName == productDataObject.data.phoneName {
                return true
            }
            count += 1
        }
        return false
    }
    
    func getAllElements(){
        for item in productDataObject.data.specifications {
            allElementsToPass.append(item)
            for spec in item.specs {
                allElementsToPass.append(spec)
            }
        }
    }
    
    func setForRemoveBtn(){
        self.addToFavoritesButton.setTitle("Remove from favorites", for: .normal)
        self.addToFavoritesButton.backgroundColor = UIColor(patternImage: UIImage(named: "Red")!)
        self.addToFavoritesButton.setTitleColor(Colors.white, for: .normal)
    }
    func setForAddBtn(){
        self.addToFavoritesButton.setTitle("Add to favorites", for: .normal)
        self.addToFavoritesButton.backgroundColor = UIColor(patternImage: UIImage(named: "Green")!)
        self.addToFavoritesButton.setTitleColor(Colors.black, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailsVC else {return}
        
        destination.productDataObject = productDataObject
        destination.allElements = allElementsToPass
    }
    
    
}

