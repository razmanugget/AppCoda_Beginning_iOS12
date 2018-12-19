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
  
  
  
  // MARK: - View controller life cycle
  // appear slowly, all at once
//  override func viewWillAppear(_ animated: Bool) {
//    UIView.animate(withDuration: 2.0) {  // 2 second duration
//      self.rateButtons[0].alpha = 1.0
//      self.rateButtons[1].alpha = 1.0
//      self.rateButtons[2].alpha = 1.0
//      self.rateButtons[3].alpha = 1.0
//      self.rateButtons[4].alpha = 1.0
//    }
//  }
  
  // appear flowing down
  override func viewWillAppear(_ animated: Bool) {
    UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: { self.rateButtons[0].alpha = 1.0}, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: { self.rateButtons[1].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: { self.rateButtons[2].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: { self.rateButtons[3].alpha = 1.0 }, completion: nil)
    UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: { self.rateButtons[4].alpha = 1.0 }, completion: nil)
  }
  
  
  // appear from the right and add visibility | see chap 17 for spring animations and 
//  override func viewWillAppear(_ animated: Bool) {
//    UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
//      self.rateButtons[0].alpha = 1.0
//      self.rateButtons[0].transform = .identity  // resets to original position from storyboard
//    }, completion: nil)
//    UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: {
//      self.rateButtons[1].alpha = 1.0
//      self.rateButtons[1].transform = .identity
//    }, completion: nil)
//    UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
//      self.rateButtons[2].alpha = 1.0
//      self.rateButtons[2].transform = .identity
//    }, completion: nil)
//    UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: {
//      self.rateButtons[3].alpha = 1.0
//      self.rateButtons[3].transform = .identity
//    }, completion: nil)
//    UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: {
//      self.rateButtons[4].alpha = 1.0
//      self.rateButtons[4].transform = .identity
//    }, completion: nil)
//  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImageView.image = UIImage(named: restaurant.image)
    
    // apply a blur effect programmatically
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    // buttons are off screen and large
//    let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
//    let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
//    let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
    
    // make the buttons invisible
    for rateButton in rateButtons {
//      rateButton.transform = moveScaleTransform   // moved to right
      rateButton.alpha = 0
    }
  }
  
}
