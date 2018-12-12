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
  var restaurantImagePassedIn = ""
  var restaurantNamePassedIn = ""
  var restaurantTypePassedIn = ""
  var restaurantLocationPassedIn = ""
  
  
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var restaurantNameLabel: UILabel!
  @IBOutlet weak var restaurantTypeLabel: UILabel!
  @IBOutlet weak var restaurantLocationLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    restaurantImageView.image = UIImage(named: restaurantImagePassedIn)
    restaurantNameLabel.text = restaurantNamePassedIn
    restaurantTypeLabel.text = restaurantTypePassedIn
    restaurantLocationLabel.text = restaurantLocationPassedIn
  }
  
}
