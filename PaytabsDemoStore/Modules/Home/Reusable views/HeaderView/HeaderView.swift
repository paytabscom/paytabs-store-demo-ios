//
//  HeaderView.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 06/09/2021.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!{
            didSet{
                moreBtn.isHidden = true
                moreBtn.backgroundColor = .clear
                moreBtn.layer.cornerRadius = 8
                moreBtn.layer.borderWidth = 2
                moreBtn.layer.borderColor = moreBtn.currentTitleColor.cgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var title:String?{
        didSet{
            titleLabel.text = title
        }
    }
    @IBAction func onClick(_ sender: UIButton) {
    let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
    
        colorAnimation.fromValue = moreBtn.currentTitleColor.cgColor
        colorAnimation.duration = 0.5  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
    }
      
    
}
