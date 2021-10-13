//
//  ViewController.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/29/21.
//

import RxSwift
import RxCocoa
import Moya
import SwiftUI


class HomeVC: BaseWireframe<HomeVM> {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = homeDataSrc
            collectionView.delegate = homeDataSrc
            collectionView.register(UINib(nibName: "HeaderView", bundle: nil ), forSupplementaryViewOfKind: "header" , withReuseIdentifier: "HeaderView")
        }
    }
    
    private lazy var homeDataSrc: HomeDataSrc! = {
        let src = HomeDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] id in
            guard let self = self else {return}
            self.navigateToDetails(id: id)
        }
        return src
    }()
    
    private lazy var compositionalLayoutHelper: HomeCompositionalLayoutHelper = {
        HomeCompositionalLayoutHelper()
    }()
    
    private lazy var cartButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(navigateToCart))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = compositionalLayoutHelper.createCompositionalLayout()
        registerCells()
        viewModel.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        if hasViewedWalkthrough { return }
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "WalkthroughVC") as? WalkthroughVC {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    @objc func navigateToCart() {
        CartVC.show(on: self)
    }
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func registerCells(){
        collectionView.register(cell: CollectionsCell.self)
        collectionView.register(cell: FeaturedCell.self)
    }
    
    override func bind(viewModel: HomeVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
    }
}

extension HomeVC {
    
    func navigateToDetails(id: Int){
        let productDetailsVM = ProductDetailsVM(dataManager: DataManager.create(), id: id)
        let detailsVC = ProductDetailsVC.make(from: .main, with: productDetailsVM)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

