//
//  ProductDetailsVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 10/09/2021.
//

import UIKit
import Kingfisher
import RealmSwift

class ProductDetailsVC: BaseWireframe<ProductDetailsVM> {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var detailedLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProductDetails()
        setupUI()
    }
    
    override func bind(viewModel: ProductDetailsVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard let self = self else { return }
                guard state else { return }
                self.assignProduct()
            }).disposed(by: disposeBag)
    }
    
    func assignProduct(){
        detailedLabel.text = viewModel.product?.welcomeDescription
        productTitle.text = viewModel.product?.title
        productPrice.text = "\(viewModel.product?.itemPrice ?? 0) $"
        productImage.kf.indicatorType = .activity
        productImage.kf.setImage(with: URL(string: viewModel.product?.image ?? ""))
    }
    
    @IBAction func addToBagClicked(_ sender: Any) {
        addButton.setTitle("Added to BAG!", for: .normal)
        addButton.backgroundColor = UIColor.init(hexString: "808080")
        addButton.setTitleColor(UIColor.black, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.addButton.setTitle("ADD TO BAG", for: .normal)
            self.addButton.backgroundColor = UIColor.init(hexString: "FF8C00")
            self.addButton.setTitleColor(UIColor.white, for: .normal)
        }
        viewModel.addToCart()
    }
    @IBAction func addToFavClicked(_ sender: Any) {
        favButton.setTitleColor(UIColor.init(hexString: "FF2E2E"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.favButton.setTitleColor(UIColor.init(hexString: "9A9A9A"), for: .normal)
        }
        viewModel.addToFavourite()
    }

    private lazy var cartButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(cartClicked(_:)))
    }()
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = cartButton
        self.tabBarController?.tabBar.isHidden = true
    }
    

    
    @IBAction func cartClicked(_ sender: Any) {
        CartVC.show(on: self)
    }
    
    @IBAction func counter(_ sender: UIStepper) {
        countlbl.text = Int(sender.value).description
        viewModel.setProductQuantity(quantity: Int(sender.value))
        productPrice.text = "$" + String(Int(viewModel.product!.price) * Int(sender.value))
    }
}
