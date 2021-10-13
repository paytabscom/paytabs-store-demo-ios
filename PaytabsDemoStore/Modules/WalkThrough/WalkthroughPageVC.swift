//
//  WalkthroughPageVC.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/30/21.
//

import UIKit

class WalkthroughPageVC: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let startingVC = contentVC(at: 0){
            navigationController?.setViewControllers([startingVC], animated: true)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index -= 1
        return contentVC(at: index)

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index += 1
        return contentVC(at: index)
    }
}

func contentVC(at index:Int )-> WalkthroughContentVC?{
    if index < 0 || index >= titles.count{
        return nil
    }
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    if let pageContentVC = storyBoard.instantiateViewController(identifier: "WalkthroughContentVC")as? WalkthroughContentVC{
        pageContentVC.imageFile = images[index]
        pageContentVC.intro = titles[index]
        pageContentVC.index = index
        return pageContentVC
    }
    return nil
}
