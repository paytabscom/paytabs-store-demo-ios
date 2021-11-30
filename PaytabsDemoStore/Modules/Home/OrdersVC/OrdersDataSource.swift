//
//  CategoriesVCDataSource.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import UIKit
import RealmSwift

class OrdersDataSrc: NSObject {
    var viewModel: OrdersVM!
}

extension OrdersDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)as? CartCell else {return UITableViewCell()}
        guard let item = viewModel.getProduct(at: indexPath.row) else {return cell}
        let currentprice = item.itemPrice * Double(item.quantity)
        cell.titlelbl =  item.title
        cell.pricelbl = currentprice
        cell.singlePricelbl = item.itemPrice
        cell.img = item.image
        cell.count = String(item.quantity)
        cell.id = item.id
        cell.stepper.isHidden = true
        return cell
        
    }
    
    
}

extension OrdersDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
