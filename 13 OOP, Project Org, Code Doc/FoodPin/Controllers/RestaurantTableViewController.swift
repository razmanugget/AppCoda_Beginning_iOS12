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
  var restaurants:[Restaurant] = [
    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isVisited: false),
    Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isVisited: false),
    Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isVisited: false),
    Restaurant(name: "Cafe loisl", type: "Austrian / Casual Drink", location: "Hong Kong", image: "cafeloisl", isVisited: false),
    Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isVisited: false),
    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant", isVisited: false),
    Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isVisited: false),
    Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isVisited: false),
    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate", isVisited: false),
    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso", isVisited: false),
    Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isVisited: false),
    Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isVisited: false),
    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats", isVisited: false),
    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf", isVisited: false),
    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isVisited: false),
    Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isVisited: false),
    Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isVisited: false),
    Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isVisited: false),
    Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isVisited: false),
    Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isVisited: false),
    Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen", isVisited: false)
  ]
  
  // MARK: - Functions
  
  
  
  // MARK: - Override Functions
  // MARK: - UITableViewDataSource Protocol
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1  // this is the default value
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurants.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "datacell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurants[indexPath.row].name
    cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
    cell.locationLabel.text = restaurants[indexPath.row].location
    cell.typeLabel.text = restaurants[indexPath.row].type
    cell.heartImageView.isHidden = restaurants[indexPath.row].isVisited ? false : true
    
    return cell
  }
  
  
  // MARK: - TableView actions
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(action, sourceView, completionHandler) in
      // delete the row from the data source
      self.restaurants.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      // call completion handler to dismiss the action button
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "Share") {(action, sourceView, completionHandler) in
      let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
      let activityController: UIActivityViewController
      if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
        activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
      } else {
        activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
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
    
    // color the options
    deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)   // specific color
    deleteAction.image = UIImage(named: "delete")
    shareAction.backgroundColor = UIColor.orange   // simple color
    shareAction.image = UIImage(named: "share")
    
    // show the options
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    return swipeConfiguration
  }
  
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let checkInAction = UIContextualAction(style: .normal, title: "Check In") {(action, sourceView, completionHandler) in
      // check-in
      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
      self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
      cell.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false : true
      
      // call completion handler to dismiss the action button
      completionHandler(true)
    }
    
    // color the options
    let checkInIcon = restaurants[indexPath.row].isVisited ? "undo" : "tick"
    checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
    checkInAction.image = UIImage(named: checkInIcon)
    
    // show the options
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
    return swipeConfiguration
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestaurantDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurant = restaurants[indexPath.row]
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // adjust width on iPad only
    tableView.cellLayoutMarginsFollowReadableWidth = true
  }
  
}
