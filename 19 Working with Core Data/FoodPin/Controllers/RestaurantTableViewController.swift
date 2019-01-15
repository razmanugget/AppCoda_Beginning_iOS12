//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Rami on 12/1/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

// MARK: - Enums | Extensions
// MARK: - IBActions


class RestaurantTableViewController: UITableViewController {
    // MARK: - Variables
    var restaurants: [RestaurantMO] = []
//        
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    // MARK: - Override Functions
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView)
        -> Int {
            return 1  // this is the default value
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cellIdentifier = "datacell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            
            cell.nameLabel.text = restaurants[indexPath.row].name
            if let restaurantImage = restaurants[indexPath.row].image {
                cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
            }
            cell.locationLabel.text = restaurants[indexPath.row].location
            cell.typeLabel.text = restaurants[indexPath.row].type
            cell.heartImageView.isHidden = restaurants[indexPath.row].isVisited ? false : true
            
            return cell
    }
    
    // MARK: - TableView actions
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
                (action, sourceView, completionHandler) in
                // delete the row from the data source
                self.restaurants.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                // call completion handler to dismiss the action button
                completionHandler(true)
            }
            
            let shareAction = UIContextualAction(style: .normal, title: "Share") {
                (action, sourceView, completionHandler) in
                let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
                let activityController: UIActivityViewController
                
                if let restaurantImage = self.restaurants[indexPath.row].image,
                    let imageToShare = UIImage(data: restaurantImage as Data) {
                    activityController = UIActivityViewController(
                        activityItems: [defaultText, imageToShare], applicationActivities: nil)
                } else {
                    activityController = UIActivityViewController(
                        activityItems: [defaultText], applicationActivities: nil)
                }
                
                // fix for iPad
                if let popoverController = activityController.popoverPresentationController {
                    if let cell = tableView.cellForRow(at: indexPath) {
                        popoverController.sourceView = cell
                        popoverController.sourceRect = cell.bounds
                    }
                }
                self.present(activityController, animated: true, completion: nil)
                completionHandler(true)
            }
            
            // color the options w/ specific color
            deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            deleteAction.image = UIImage(named: "delete")
            shareAction.backgroundColor = UIColor.orange   // simple color
            shareAction.image = UIImage(named: "share")
            
            // show the options
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
            return swipeConfiguration
    }
    
    
    override func tableView
        (_ tableView: UITableView,
         leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            let checkInAction = UIContextualAction(style: .normal, title: "Check In") {
                (action, sourceView, completionHandler) in
                // check-in
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
                cell.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false : true
                
                // call completion handler to dismiss the action button
                completionHandler(true)
            }
            
            // color the options
            let checkInIcon = restaurants[indexPath.row].isVisited ? "undo" : "tick"
            // using the extension here for simplier color choice
            checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
            checkInAction.image = UIImage(named: checkInIcon)
            
            // show the options
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
            return swipeConfiguration
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    
    // MARK: - View controller life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide nav bar just for this scene
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nav bar customization
        navigationController?.navigationBar.prefersLargeTitles = true
        // to make background transparent, set image and shadow to blank UIImage
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
                NSAttributedString.Key.font: customFont
            ]
        }
        
        tableView.separatorStyle = .none
        
        // adjust width on iPad only
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
}
