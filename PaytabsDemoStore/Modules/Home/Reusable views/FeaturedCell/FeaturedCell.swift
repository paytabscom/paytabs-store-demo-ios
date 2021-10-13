//
//  FeaturedCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 06/09/2021.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var titlelbl:String?{
        didSet{
            titleLabel.text = titlelbl
        }
    }
    var pricelbl:String?{
        didSet{
            priceLabel.text = pricelbl
        }
    }
    var img:String?{
        didSet{
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: img!))
        }
    }
    //TODO UIImage

}
