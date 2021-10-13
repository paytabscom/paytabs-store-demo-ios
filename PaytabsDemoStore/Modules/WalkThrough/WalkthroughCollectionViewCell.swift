//
//  WalkthroughCollectionViewCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/30/21.
//

import UIKit

class WalkthroughCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: WalkthroughCollectionViewCell.self)
    
    @IBOutlet weak var slideDescLabel: UILabel!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setup(_ slide:walkthroughData){
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescLabel.text  = slide.desc
        
    }
}
