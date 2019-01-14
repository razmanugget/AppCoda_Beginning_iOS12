//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by Rami on 12/20/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

  let padding = UIEdgeInsets(
    top: 0,
    left: 10,
    bottom: 0,
    right: 10
    )
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.layer.cornerRadius = 5.0
    self.layer.masksToBounds = true
  }

}
