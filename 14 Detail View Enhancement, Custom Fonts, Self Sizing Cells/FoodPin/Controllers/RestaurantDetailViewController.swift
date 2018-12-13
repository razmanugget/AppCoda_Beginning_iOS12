//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Rami on 12/11/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  
  // MARK: - Variables
  var restaurant = Restaurant()
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var headerView: RestaurantDetailHeaderView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
    // configure header view
    headerView.headerImageView.image = UIImage(named: restaurant.image)
    headerView.nameLabel.text = restaurant.name
    headerView.typeLabel.text = restaurant.type
    headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
  }
  
}
