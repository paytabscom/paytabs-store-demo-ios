//
//  CartCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 18/09/2021.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class CartCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var productSinglePrice: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var currentStepper:Double = 1
    var id:Int = 0
    
    
    var titlelbl:String?{
        didSet{
            productTitle.text = titlelbl
        }
    }
    
    var pricelbl:Double?{
        didSet{
            productPrice.text = "$\(String(pricelbl?.rounded(toPlaces: 2) ?? 0))"
            
        }
    }
    
    var singlePricelbl:Double?{
        didSet{
            productSinglePrice.text = "$\(String(singlePricelbl?.rounded(toPlaces: 2) ?? 0))"
        }
    }
    
    var count:String?{
        didSet{
            productCount.text = count
            currentStepper = Double(count ?? "1") ?? 1
        }
    }
    
    var img:String?{
        didSet{
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: URL(string: img!))
        }
    }
    
    var updateProductQuantity: ((_ quantity:Int) -> ())?
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        currentStepper = sender.value
        count = String(Int(currentStepper))
        pricelbl = currentStepper * singlePricelbl!
        updateProductQuantity?(Int(currentStepper))
    }
    
}
