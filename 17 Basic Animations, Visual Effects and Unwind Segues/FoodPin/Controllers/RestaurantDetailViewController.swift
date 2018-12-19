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
    return 5
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
    case 3:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailSeparatorCell.self), for: indexPath) as! RestaurantDetailSeparatorCell
      cell.titleLabel.text = "HOW TO GET HERE"
      cell.selectionStyle = .none
      return cell
    case 4:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
      cell.configure(location: restaurant.location)
      cell.selectionStyle = .none
      return cell
    default:
      fatalError("Failed to instantiate the table view cell for detail view controller")
    }
  }
  
  
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMap" {
      let destinationController = segue.destination as! MapViewController
      destinationController.restaurant = restaurant
    }
  }
  
  
  
  // MARK: - View controller life cycle
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // show nav bar just for this scene
    navigationController?.hidesBarsOnSwipe = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // customize nav bar
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.tintColor = .white
    // keeps the nav bar from blocking the top content (default is .always)
    tableView.contentInsetAdjustmentBehavior = .never
    
    // link data
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    
    // configure header view
    headerView.headerImageView.image = UIImage(named: restaurant.image)
    headerView.nameLabel.text = restaurant.name
    headerView.typeLabel.text = restaurant.type
    headerView.backgroundTypeLabel.text = "   " + restaurant.type + "   "
    headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
  }
  
}
