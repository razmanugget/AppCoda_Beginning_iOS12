//
//  ViewController.swift
//  03 Exercise 2 - Hello World
//
//  Created by Rami on 11/29/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let iconArray = ["alien", "ghost", "brainy", "robot"]
  
  
  @IBAction func showMessage(_ sender: UIButton) {
    let alertController = UIAlertController(title: "Welcome to my first App", message: messageText(option: sender.tag), preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    present(alertController, animated: true, completion: nil)
    print(sender.tag)
  }
  
  
  func messageText(option: Int) -> String {
    return "hello from \(iconArray[option-1])"
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
}

