//
//  CategoriesVCDataSource.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import Foundation
import UIKit

class CategoriesDataSrc: NSObject {
    var viewModel: CategoriesVM!
    
    var onItemSelected: ((String) -> Void)? = nil

    
}

extension CategoriesDataSrc: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)as? CategoriesCell else { return UICollectionViewCell() }
        guard let category = viewModel.getCategory(at: indexPath.row) else { return cell }
        cell.image = viewModel.getImage(at: category)
        cell.titlelbl = category.capitalized
        
        return cell
    }
    
    
}

extension CategoriesDataSrc: UICollectionViewDelegate{

}

extension CategoriesDataSrc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = viewModel.getCategory(at: indexPath.row) else { return }
        onItemSelected?(category)
        print("selected!")

    }
}
