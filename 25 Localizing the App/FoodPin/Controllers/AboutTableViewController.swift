//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Rami on 2/20/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    // MARK: - Variables
    var sectionTitles = [
        NSLocalizedString("Feedback", comment: "Feedback"), 
        NSLocalizedString("Follow Us", comment: "Follow Us") 
    ]
    var sectionContent = [
        [
            (image: "store", 
             text: NSLocalizedString("Rate us on App Store", comment: "Rate us on App Store"), 
             link: "https://www.apple.com/itunes/charts/paid-apps/"),
            (image: "chat", 
             text: NSLocalizedString("Tell us your feedback", comment: "Tell us your feedback"), 
             link: "http://www.appcoda.com/contact")
        ], [
            (image: "twitter", 
             text: NSLocalizedString("Twitter", comment: "Twitter"), 
             link: "https://twitter.com/appcodamobile"),
            (image: "facebook", 
             text: NSLocalizedString("Facebook", comment: "Facebook"), 
             link: "https://facebook.com/appcodamobile"),
            (image: "instagram", 
             text: NSLocalizedString("Instagram", comment: "Instagram"), 
             link: "https://www.instagram.com/appcodadotcom")]
    ]
    
    // MARK: - Override Functions
    
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
    
    override func tableView(
        _ tableView: UITableView, 
        cellForRowAt indexPath: IndexPath) 
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "AboutCell", 
                for: indexPath)
            
            // configure the cell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.textLabel?.text = cellData.text
            cell.imageView?.image = UIImage(named: cellData.image)
            
            return cell
    }
    
    override func tableView(
        _ tableView: UITableView, 
        didSelectRowAt indexPath: IndexPath) {
        
        let link = sectionContent[indexPath.section][indexPath.row].link
        
        switch indexPath.section {
            // leave us feedback section
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "showWebView", sender: self)
            }
            // follow us section
        case 1:
            if let url = URL(string: link) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            if let destinationController = segue.destination as? WebViewController, 
                let indexPath = tableView.indexPathForSelectedRow {
                destinationController.targetURL = sectionContent[indexPath.section][indexPath.row].link
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // configure the navigation bar appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ 
                NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), 
                NSAttributedString.Key.font: customFont ]
        }
        tableView.tableFooterView = UIView()
    }
    
}
