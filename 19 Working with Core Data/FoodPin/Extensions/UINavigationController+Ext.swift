//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Rami on 12/14/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // allow different statusbar styles in different scenes
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
