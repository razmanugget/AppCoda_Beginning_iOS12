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
             // swiftlint:disable:next force_cast
            var index = (viewController as! WalkthroughContentViewController).index
            index -= 1
            
            return contentViewController(at: index)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController, 
        viewControllerAfter viewController: UIViewController) 
        -> UIViewController? {
             // swiftlint:disable:next force_cast
            var index = (viewController as! WalkthroughContentViewController).index
            index += 1
            
            return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) 
        -> WalkthroughContentViewController? {
            if index < 0 || index >= pageHeadings.count {
                return nil
            }
            
            // create a new view controller and pass data
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            if let pageContentViewController = storyboard.instantiateViewController(
                withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
                pageContentViewController.imageFile = pageImages[index]
                pageContentViewController.heading = pageHeadings[index]
                pageContentViewController.subHeading = pageSubHeadings[index]
                pageContentViewController.index = index
                return pageContentViewController
            }
            return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        // set the data source to itself
        dataSource = self
        
        // create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}
