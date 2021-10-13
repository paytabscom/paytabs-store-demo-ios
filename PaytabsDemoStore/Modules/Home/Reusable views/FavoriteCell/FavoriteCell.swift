//
//  FavoriteCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 25/09/2021.
//

import UIKit
import Kingfisher

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    
    var titlelbl:String?{
        didSet{
            productLabel.text = titlelbl
        }
    }
    var img:String?{
        didSet{
            favoriteImage.kf.indicatorType = .activity
            favoriteImage.kf.setImage(with: URL(string: img!))
        }
    }
}
