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
    cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // create an option menu as an action sheet
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    
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
    
    // check-in action (closure is in-line (preferred usage))
    let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {(action: UIAlertAction!) -> Void in
      
      let cell = tableView.cellForRow(at: indexPath)
      cell?.accessoryType = .checkmark
      self.restaurantIsVisited[indexPath.row] = true
    })
    optionMenu.addAction(checkInAction)
    
    // display the menu
    present(optionMenu, animated: true, completion: nil)
    
    if let popoverController = optionMenu.popoverPresentationController {
      if let cell = tableView.cellForRow(at: indexPath) {
        popoverController.sourceView = cell
        popoverController.sourceRect = cell.bounds
      }
    }
    
    // deselect the row
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // adjust width on iPad only
//    tableView.cellLayoutMarginsFollowReadableWidth = true
  }
  
}
