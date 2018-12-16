//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Rami on 12/13/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var heartImageView: UIImageView! {
    didSet {
      heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
      heartImageView.tintColor = .white
    }
  }
   
}
