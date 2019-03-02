//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Rami on 2/15/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, 
WalkthroughPageViewControllerDelegate {
    // MARK: - Variables
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        createQuickActions()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(
        sender: UIButton) {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                createQuickActions()
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        updateUI()
    }
    
    func createQuickActions() {
        // add quick actions, 1st check for 3d touch capable
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                let shortcutItem1 = UIApplicationShortcutItem(
                    type: "\(bundleIdentifier).openFavorites", 
                    localizedTitle: "Show Favorites", 
                    localizedSubtitle: nil, 
                    icon: UIApplicationShortcutIcon(templateImageName: "favorite"), 
                    userInfo: nil)
                let shortcutItem2 = UIApplicationShortcutItem(
                    type: "\(bundleIdentifier).openDiscover", 
                    localizedTitle: "Discover Restaurants", 
                    localizedSubtitle: nil, 
                    icon: UIApplicationShortcutIcon(templateImageName: "discover"), 
                    userInfo: nil)
                let shortcutItem3 = UIApplicationShortcutItem(
                    type: "\(bundleIdentifier).newRestaurant", 
                    localizedTitle: "New Restaurant", 
                    localizedSubtitle: nil, 
                    icon: UIApplicationShortcutIcon(type: .add), 
                    userInfo: nil)
                UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
            }
        }
    }
    
    
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func prepare(
        for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
