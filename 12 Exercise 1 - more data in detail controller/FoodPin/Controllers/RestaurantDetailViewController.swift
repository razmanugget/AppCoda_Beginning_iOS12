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
  var restaurantImageName = ""
  
  @IBOutlet weak var restaurantImageView: UIImageView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    restaurantImageView.image = UIImage(named: restaurantImageName)
    
  }
  
}
