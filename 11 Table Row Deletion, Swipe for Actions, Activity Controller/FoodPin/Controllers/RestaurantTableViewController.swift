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
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
  
  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var restaurantIsVisited = Array(repeating: false, count: 21)
  
  
  // MARK: - Functions
  
  
  
  // MARK: - Override Functions
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1  // this is the default value
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantNames.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "datacell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurantNames[indexPath.row]
    cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
    cell.locationLabel.text = restaurantLocations[indexPath.row]
    cell.typeLabel.text = restaurantTypes[indexPath.row]
    cell.heartImageView.isHidden = restaurantIsVisited[indexPath.row] ? false : true
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // create an option menu as an action sheet
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    
    // fix for iPad
    if let popoverController = optionMenu.popoverPresentationController {
      if let cell = tableView.cellForRow(at: indexPath) {
        popoverController.sourceView = cell
        popoverController.sourceRect = cell.bounds
      }
    }
    
    // add actions to the menu
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    optionMenu.addAction(cancelAction)
    
    // add call action
    let callActionHandler = {(action: UIAlertAction!) -> Void in
      let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alertMessage, animated: true, completion: nil)
    }
    
    let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
    optionMenu.addAction(callAction)
    
    // switch title based on checkmark
    let checkActionTitle = (restaurantIsVisited[indexPath.row]) ? "Undo Check in" : "Check in"
    
    // check-in action (closure is in-line (preferred usage))
    let checkInAction = UIAlertAction(title: checkActionTitle, style: .default, handler: {(action: UIAlertAction!) -> Void in
      
      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
      
      self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
      
      cell.heartImageView.isHidden = self.restaurantIsVisited[indexPath.row] ? false : true
    })
    
    optionMenu.addAction(checkInAction)
    
    // display the menu
    present(optionMenu, animated: true, completion: nil)
    
    // deselect the row
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(action, sourceView, completionHandler) in
      // delete the row from the data source
      self.restaurantNames.remove(at: indexPath.row)
      self.restaurantLocations.remove(at: indexPath.row)
      self.restaurantTypes.remove(at: indexPath.row)
      self.restaurantIsVisited.remove(at: indexPath.row)
      self.restaurantImages.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      // call completion handler to dismiss the action button
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "Share") {(action, sourceView, completionHandler) in
      let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
      let activityController: UIActivityViewController
      if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
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
  
  // use this if you want a swipe to perform just 1 action
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//      if editingStyle == .delete {
//        // delete the row from the data source
//        restaurantNames.remove(at: indexPath.row)
//        restaurantLocations.remove(at: indexPath.row)
//        restaurantTypes.remove(at: indexPath.row)
//        restaurantIsVisited.remove(at: indexPath.row)
//        restaurantImages.remove(at: indexPath.row)
//      }
//      tableView.deleteRows(at: [indexPath], with: .fade)
//    }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // adjust width on iPad only
    tableView.cellLayoutMarginsFollowReadableWidth = true
  }
  
}
