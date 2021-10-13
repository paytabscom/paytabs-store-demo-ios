//
//  CategoriesCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 13/09/2021.
//

import UIKit
import Kingfisher

class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var titlelbl:String?{
        didSet{
            titleLabel.text = titlelbl
        }
    }
    var image:UIImage?{
        didSet{
            categoryImage.image = image
        }
    }
}
