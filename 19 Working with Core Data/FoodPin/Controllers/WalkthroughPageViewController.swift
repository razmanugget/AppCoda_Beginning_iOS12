//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Rami on 2/15/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    var pageHeadings = [
        "Create your own food guide", 
        "Show you the location", 
        "Discover great restaurants"
    ]
    var pageImages = [
        "onboarding-1", 
        "onboarding-2", 
        "onboarding-3"
    ]
    var pageSubHeadings = [
        "Pin your favorite restaurants and create your own food guide", 
        "Search and locate your favorite restaurant on Maps", 
        "Find restaurants shared by your friends and other foodies"
    ]
    var currentIndex = 0
    
    func pageViewController(
        _ pageViewController: UIPageViewController, 
        viewControllerBefore viewController: UIViewController) 
        -> UIViewController? {
            var index = (viewController as! WalkthroughContentViewController).index
            index -= 1
            
            return contentViewController(at: index)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController, 
        viewControllerAfter viewController: UIViewController) 
        -> UIViewController? {
            <#code#>
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
