//
//  CategoriesDetailsCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 29/09/2021.
//

import UIKit

class CategoriesDetailsCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var titlelbl:String?{
        didSet{
            productTitle.text = titlelbl
        }
    }
    
    var pricelbl:String?{
        didSet{
            productPrice.text = pricelbl
        }
    }
    
    var img:String?{
        didSet{
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: URL(string: img!))
        }
    }
}
