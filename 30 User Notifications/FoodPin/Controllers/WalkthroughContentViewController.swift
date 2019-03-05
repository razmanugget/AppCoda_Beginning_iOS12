//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Rami on 2/13/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
  var index = 0
  var heading = ""
  var subHeading = ""
  var imageFile = ""
  
  @IBOutlet var headingLabel: UILabel! {
    didSet {
      headingLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet var subHeadingLabel: UILabel! {
    didSet {
      subHeadingLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet var contentImageView: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headingLabel.text = heading
    subHeadingLabel.text = subHeading
    contentImageView.image = UIImage(named: imageFile)
  }
  
}
