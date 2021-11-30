//
//  HomeVCDataSrc.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 12/09/2021.
//

import UIKit

class HomeDataSrc: NSObject {
    var viewModel: HomeVM!
    
    var onItemSelected: ((Int) -> Void)? = nil
}

extension HomeDataSrc: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return viewModel.getWomenClothesCount()
        case 1:
            return viewModel.getProductCount()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath)as? FeaturedCell else { return UICollectionViewCell() }
            guard let product = viewModel.getWomenClothes(at: indexPath.row) else {
                return cell
            }
            cell.titlelbl = product.title
            cell.img = product.image
            cell.pricelbl = "$\(String(product.itemPrice))"
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath)as? FeaturedCell else { return UICollectionViewCell() }
            guard let product = viewModel.getProduct(at: indexPath.row) else {
                return cell
            }
            cell.titlelbl = product.title
            cell.pricelbl = "$\(String(product.itemPrice))"
            cell.img = product.image
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCell", for: indexPath)as? CollectionsCell else { return UICollectionViewCell() }
            return cell
        }
    }
}

extension HomeDataSrc: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let product = viewModel.getWomenClothes(at: indexPath.row) else {return}
            onItemSelected?(product.id)
            
        case 1:
            guard let product = viewModel.getProduct(at: indexPath.row) else {return}
            onItemSelected?(product.id)
            
        default:
            print("TODO")
        }
    }
}
