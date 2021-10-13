//
//  CategoriesVCDataSource.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import UIKit
import RealmSwift

class FavoritesDataSrc: NSObject {
    var viewModel: FavoritesVM!
    
    var onItemSelected: ((Int) -> Void)? = nil
}

extension FavoritesDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)as? FavoriteCell else {return UITableViewCell()}
        guard let item = viewModel.getProduct(at: indexPath.row) else {return cell}
        cell.titlelbl =  item.title
        cell.img = item.image
        return cell
        
    }
}

extension FavoritesDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = viewModel.getProduct(at: indexPath.row) else {return}
        onItemSelected?(product.id)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            viewModel.deleteFavourite(index: indexPath.row)
        }
    }
}
