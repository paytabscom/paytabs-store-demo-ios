//
//  WalkthroughViewController.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/30/21.
//

import UIKit

class WalkthroughVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage ==  slides.count - 1{
                nextButton.setTitle("   Get started!   ", for: .normal)
            }else{
                nextButton.setTitle("   Next   ", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlides()
        pageControl.numberOfPages = slides.count
    }

    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1{
            UserDefaults.standard.setValue(true, forKey: "hasViewedWalkthrough")
            let tabBar = MainTabBar.instantiate(storyboard: .main)
            tabBar.modalPresentationStyle = .fullScreen
            present(tabBar, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexpath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        }
        
    }
}

extension WalkthroughVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCollectionViewCell.identifier, for: indexPath)as! WalkthroughCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}
