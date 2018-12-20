//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Rami on 12/3/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//


import UIKit

class RestaurantTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var backgroundTypeLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView! {
    didSet {
      thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 2
      thumbnailImageView.clipsToBounds = true
    }
  }
  @IBOutlet weak var heartImageView: UIImageView!
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    
  }
}
