//
//  ViewController.swift
//  SimpleTable
//
//  Created by Rami on 12/1/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

// MARK: - Enums | Extensions
// MARK: - IBActions


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  // MARK: - Variables
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  
  
  // MARK: - Functions
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "datacell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    // configure the cell
    cell.textLabel?.text = restaurantNames[indexPath.row]
    cell.imageView?.image = UIImage(named: "restaurant")
    
    return cell
  }
  
  
  
  // MARK: - Override Functions
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
}

