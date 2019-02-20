//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Rami on 2/20/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    // MARK: - Variables
    var sectionTitles = ["Feedback", "Follow Us"]
    var sectionContent = [
        [
            (image: "store", 
             text: "Rate us on the App Store", 
             link: "https://www.apple.com/itunes/charts/paid-apps/"),
            (image: "chat", 
             text: "Tell us your feedback", 
             link: "http://www.appcoda.com/contact")
        ],
        [
            (image: "twitter", 
             text: "Twitter", 
             link: "https://twitter.com/appcodamobile"),
            (image: "facebook", 
             text: "Facebook", 
             link: "https://facebook.com/appcodamobile"),
            (image: "instagram", 
             text: "Instagram", 
             link: "https://www.instagram.com/appcodadotcom")
        ]
    ]
    
    
    override func numberOfSections(
        in tableView: UITableView) 
        -> Int {
            
            return sectionTitles.count
    }
    
    override func tableView(
        _ tableView: UITableView, 
        numberOfRowsInSection section: Int) 
        -> Int {
            
            return sectionContent[section].count
    }
    
    override func tableView(
        _ tableView: UITableView, 
        titleForHeaderInSection section: Int)
        -> String? {
            
            return sectionTitles[section]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
