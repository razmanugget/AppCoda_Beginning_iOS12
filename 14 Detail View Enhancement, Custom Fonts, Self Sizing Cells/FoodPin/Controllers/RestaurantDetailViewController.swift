//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Rami on 12/11/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Variables
  var restaurant = Restaurant()
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var headerView: RestaurantDetailHeaderView!
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      // using this version (describing) instead of other will show errors if the cell ID isn't found
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "phone")
      cell.shortTextLabel.text = restaurant.phone
      cell.selectionStyle = .none
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "map")
      cell.shortTextLabel.text = restaurant.location
      cell.selectionStyle = .none
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
      cell.descriptionLabel.text = restaurant.description
      cell.selectionStyle = .none
      return cell
    default:
      fatalError("Failed to instantiate the table view cell for detail view controller")
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    
    
    // configure header view
    headerView.headerImageView.image = UIImage(named: restaurant.image)
    headerView.nameLabel.text = restaurant.name
    headerView.typeLabel.text = restaurant.type
    headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
  }
  
}
