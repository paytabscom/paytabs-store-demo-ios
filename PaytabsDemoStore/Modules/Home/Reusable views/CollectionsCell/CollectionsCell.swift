//
//  CollectionsCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 06/09/2021.
//

import UIKit
import Kingfisher

class CollectionsCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var titlelbl:String?{
        didSet{
            titleLabel.text = titlelbl
        }
    }
    var img:String?{
        didSet{
            cellImage.kf.indicatorType = .activity
            cellImage.kf.setImage(with: URL(string: img!))
        }
    }
    

}
