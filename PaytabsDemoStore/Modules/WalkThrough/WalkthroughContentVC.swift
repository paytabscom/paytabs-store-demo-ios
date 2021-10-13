//
//  WalkthroughContentVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/29/21.
//

import UIKit

class WalkthroughContentVC: UIViewController {
    
    

    var index = 0
    var imageFile:UIImage!
    var intro:String = ""
    


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introLabel: UILabel!{
        didSet{
            introLabel.numberOfLines = 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



