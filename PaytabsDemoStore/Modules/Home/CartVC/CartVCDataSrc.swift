//
//  CartVCDataSrc.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 15/09/2021.
//

import Foundation
import UIKit
import RealmSwift

class CartVCDataSrc: NSObject {
    var viewModel: CartVM!

}

extension CartVCDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)as? CartCell else {return UITableViewCell()}
        guard let item = viewModel.getProduct(at: indexPath.row) else {return cell}
        let currentprice = item.price * Double(item.quantity)
        cell.titlelbl =  item.title
        cell.pricelbl = currentprice
        cell.singlePricelbl = item.price
        cell.img = item.image
        cell.count = String(item.quantity)
        cell.id = item.id
        cell.stepper.value = Double(item.quantity)
        cell.updateProductQuantity = { [weak self] quantity in
            guard let self = self else {
                return
            }
            self.viewModel.updateProductQuantity(index: indexPath.row, Quantity: quantity)
        }
        return cell
    }
}

extension CartVCDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            viewModel.deleteProduct(index: indexPath.row)
        }
    }
}

