//
//  FavoritesVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/10/21.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables and Constants
    
    let searchApi = SearchApi()
    let productApi = ProductApi()
    let context = (SharedProperties.context)!
    var favorites = [SavedProductDataObject]()
    var selectedProductObject: ProductDataObject!
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        title = "Favorites"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchFavorites()
    }
    
    
    //MARK: - Protocols Methods Implementations
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCell") as? ProductCell {
            cell.configureCell(brand: favorites[indexPath.row].brandName, phoneName: favorites[indexPath.row].phoneName, image: favorites[indexPath.row].phoneImage)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        getProductObject(phoneName: favorites[indexPath.row].phoneName)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {[weak self] action, view, completion in

            guard let self = self else {return}

            let favoriteToRemove = self.favorites[indexPath.row]
            self.context.delete(favoriteToRemove)
            self.fetchFavorites()
            self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)

            do {
                try self.context.save()

            } catch {
                debugPrint(error.localizedDescription)
            }
        }

        return UISwipeActionsConfiguration(actions: [action])
    }


//MARK: - Methods

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? SingleProductVC else {return}
    destination.productDataObject = selectedProductObject
}

func fetchFavorites(){
    
    do {
        favorites = try context.fetch(SavedProductDataObject.fetchRequest())
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
    catch {
        print("couldn't fetch from coredata")
        debugPrint(error.localizedDescription)
    }
}

func getProductObject(phoneName: String?){
    guard let phoneName = phoneName else {return}
    
    searchApi.searchWithNameUrlSession(phoneName: phoneName) {[weak self] brandObject in
        guard let brandObject = brandObject,
              let self = self else {
                  self?.activityIndicator.stopAnimating()
                  return}
        self.productApi.getProductUrlSession(url: "\(SharedProperties.BASE_URL)\(brandObject.data.phones[0].slug)") {[weak self] productObject in
            
            guard let productObject = productObject,
                  let self = self else {
                      self?.activityIndicator.stopAnimating()
                      return}
            self.selectedProductObject = productObject
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: Segue.fromFavoritesToSingleProductVC, sender: self)
            }
        }
    }
}

}
