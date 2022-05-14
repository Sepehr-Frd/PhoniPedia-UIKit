//
//  SearchVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/13/21.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    //MARK: - Variables and Constants
    
    let defaultMessage = "No product was found.\n Please try another product name."
    let selfNilMessage = "Something went wrong. Please try again."
    let searchApi = SearchApi()
    let productApi = ProductApi()
    var selectedProduct: ProductDataObject!
    var searchResult: BrandDataObject?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: RoundedLabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchBar.delegate = self
        searchBar.searchTextField.becomeFirstResponder()
        noResultsLabel.text = defaultMessage
        noResultsLabel.isHidden = true
        title = "Search"
    }
    
    
    //MARK: - IBActions
    
    @IBAction func searchClicked(_ sender: Any) {
        guard let searchText = searchBar.text else {return}
        guard searchText.isNotEmpty else {return}
        self.view.endEditing(true)
        activityIndicator.startAnimating()
        searchApi.searchWithNameUrlSession(phoneName: searchText) { [weak self] brandDataObject in
            guard let brandObject = brandDataObject else {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                return
            }
            guard let self = self else {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.noResultsLabel.text = self?.selfNilMessage
                    self?.noResultsLabel.isHidden = false
                }
                return
            }
            self.searchResult = brandObject
            DispatchQueue.main.async {
                if brandObject.data.phones.count == 0 {
                    self.noResultsLabel.text = self.defaultMessage
                    self.noResultsLabel.isHidden = false
                }
                self.activityIndicator.stopAnimating()
                self.searchResultTableView.reloadData()
            }
        }
    }
    
    //MARK: - Protocols Methods Implementations
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchClicked(self)
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        noResultsLabel.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.data.phones.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath) as? ProductCell {
            cell.configureCell(brand: searchResult?.data.phones[indexPath.row].brand, phoneName: searchResult?.data.phones[indexPath.row].name, image: searchResult?.data.phones[indexPath.row].image)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchResult = searchResult else {
            return
        }
        activityIndicator.startAnimating()
        getProductObject(slug: searchResult.data.phones[indexPath.row].slug)
    }
    
    //MARK: - Methods
    
    
    func getProductObject(slug: String){
        productApi.getProductUrlSession(url: "\(SharedProperties.BASE_URL)\(slug)") {[weak self] productDataObject in
            guard let productObject = productDataObject,
                  let self = self else {
                      self?.activityIndicator.stopAnimating()
                      return
                  }
            self.selectedProduct = productObject
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Segue.fromSearchToSingleProductVC, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleProductVC,
              let productDataObject = self.selectedProduct else {return}
        destination.productDataObject = productDataObject
        activityIndicator.stopAnimating()
    }
}
