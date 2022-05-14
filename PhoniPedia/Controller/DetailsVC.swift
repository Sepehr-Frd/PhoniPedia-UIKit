//
//  DetailsVC.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/7/21.
//

import UIKit

class DetailsVC: UITableViewController {
    
    //MARK: - Variables and Constants
    
    var indexForTitle = 0
    var indexForSpec = 0
    var specificationsArray: [Specification] {
        let specsArray = productDataObject.data.specifications
        return specsArray
    }
    var productDataObject: ProductDataObject!
    var rowGuide = [0]
    var allElements = [Any]()
  
    
    //MARK: - IBOutlets
    
    @IBOutlet var detailsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRowGuide()
        title = "Details"
    }
    
    
    //MARK: - Protocols Methods Implementations
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if rowGuide.contains(indexPath.row){
            
            if let cell = detailsTableView.dequeueReusableCell(withIdentifier: "detailsLabelCell", for: indexPath) as? DetailsLabelCell {
                
                guard let indexOfelement = rowGuide.firstIndex(of: indexPath.row) else {return UITableViewCell()}
                cell.configureCell(title: specificationsArray[indexOfelement].title)
                return cell
            }
        }
        else {
            if let cell = detailsTableView.dequeueReusableCell(withIdentifier: "detailsDescCell", for: indexPath) as? DetailsDescCell {
                guard let object = allElements[indexPath.row] as? Spec else {
                    return UITableViewCell()
                }
                cell.configureCell(spec: object)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalNumber = 0
        for item in specificationsArray {
            
            totalNumber += item.specs.count
        }
        totalNumber += specificationsArray.count
        return totalNumber
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.cellForRow(at: indexPath)?.tag == 0 {
            return 50
        }
        else {
            return 80
        }
    }
    
    //MARK: - Methods
    
    func getRowGuide(){
        var count = 0
        for item in productDataObject.data.specifications {
            for _ in 0 ..< item.specs.count {
                count += 1
            }
            count += 1
            rowGuide.append(count)
        }
        let _ = rowGuide.popLast()
    }
    
}
