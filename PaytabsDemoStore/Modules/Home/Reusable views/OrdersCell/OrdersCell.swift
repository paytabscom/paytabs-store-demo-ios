//
//  OrdersCell.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 25/09/2021.
//

import UIKit
import Kingfisher

class OrdersCell: UITableViewCell {

    @IBOutlet weak var refrencelbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    
    var refrence:String?{
        didSet{
            refrencelbl.text = refrence
        }
    }
    
    var time:String?{
        didSet{
            timelbl.text = time
        }
    }
    
    var price:String?{
        didSet{
            pricelbl.text = price
        }
    }
}
