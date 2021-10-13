//
//  ProfileDataSource.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 24/09/2021.
//

import Foundation
import UIKit

class ProfileDataSrc: NSObject {
    var viewModel: ProfileVM!
    var onItemSelected: (() -> Void)? = nil

}

extension ProfileDataSrc: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.profileList[indexPath.row]
        cell.imageView?.image = viewModel.profileImages[indexPath.row]
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return cell
        
    }
    
}

extension ProfileDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            "https://site.paytabs.com/en/about/".openURL()
        case 1:
            "https://site.paytabs.com/en/contact/".openURL()
        case 2:
            onItemSelected?()
        default:
            print("item\(indexPath.row)is selected")
        }
    }
}

