//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Rami on 12/18/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
  var restaurant = Restaurant()
  
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var rateButtons: [UIButton]!
  @IBOutlet var closeButton: UIButton!
  
  
  // MARK: - View controller life cycle
  override func viewWillAppear(_ animated: Bool) {
    // buttons appear flowing down
    UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: { self.rateButtons[0].alpha = 1.0}, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: { self.rateButtons[1].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: { self.rateButtons[2].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: { self.rateButtons[3].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: { self.rateButtons[4].alpha = 1.0 }, completion: nil)
    
    // close button slides in from right
    UIView.animate(withDuration: 1.0, delay: 0.15, options: [], animations: {
      self.closeButton.alpha = 1.0
      self.closeButton.transform = .identity  // resets to original position from storyboard
    }, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImageView.image = UIImage(named: restaurant.image)
    
    // apply a blur effect programmatically
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    // close button offscreen
    let moveRightTransform = CGAffineTransform.init(translationX: 400, y: 0)
    closeButton.transform = moveRightTransform
    closeButton.alpha = 0
    
    // make the buttons invisible
    for rateButton in rateButtons {
      //      rateButton.transform = moveScaleTransform   // moved to right
      rateButton.alpha = 0
    }
  }
  
}
