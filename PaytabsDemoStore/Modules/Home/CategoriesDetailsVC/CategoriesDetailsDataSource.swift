//
//  CategoriesDetailsDataSource.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 29/09/2021.
//

import Foundation
import UIKit

class CategoriesDetailsDataSrc: NSObject {
    var viewModel: CategoriesDetailsVM!
    
    var onItemSelected: ((Int) -> Void)? = nil

}

extension CategoriesDetailsDataSrc: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesDetailsCell", for: indexPath)as? CategoriesDetailsCell else { return UITableViewCell() }
        guard let item = viewModel.getProduct(at: indexPath.row) else {return cell}
        cell.titlelbl =  item.title
        cell.pricelbl = "$\(item.itemPrice)"
        cell.img = item.image
        return cell

    }
    
    
}

extension CategoriesDetailsDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = viewModel.getProduct(at: indexPath.row) else {return}
        onItemSelected?(product.id)
    }
    
}
