//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Rami on 12/20/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet var nameTextField: RoundedTextField! {
    didSet {
      nameTextField.tag = 1
      nameTextField.becomeFirstResponder()
      nameTextField.delegate = self
    }
  }
  
  @IBOutlet var typeTextField: RoundedTextField! {
    didSet {
      typeTextField.tag = 2
      typeTextField.delegate = self
    }
  }
  
  @IBOutlet var addressTextField: RoundedTextField! {
    didSet {
      addressTextField.tag = 3
      addressTextField.delegate = self
    }
  }
  
  @IBOutlet var phoneTextField: RoundedTextField! {
    didSet {
      phoneTextField.tag = 4
      phoneTextField.delegate = self
    }
  }
  
  @IBOutlet var descriptionTextView: UITextView! {
    didSet {
      descriptionTextView.tag = 5
      descriptionTextView.layer.cornerRadius = 5.0
      descriptionTextView.layer.masksToBounds = true
    }
  }
  
  @IBOutlet var photoImageView: UIImageView!
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextTextField = view.viewWithTag(textField.tag + 1) {
      textField.resignFirstResponder()
      nextTextField.becomeFirstResponder()
    }
    
    return true
  }
  
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage
      photoImageView.contentMode = .scaleAspectFill
      photoImageView.clipsToBounds = true
    }
    
    let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
    leadingConstraint.isActive = true
    
    let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
    trailingConstraint.isActive = true
    
    let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
    topConstraint.isActive = true
    
    let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
    bottomConstraint.isActive = true
    
    dismiss(animated: true, completion: nil)
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
      let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action) in
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          let imagePicker = UIImagePickerController()
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .camera
          imagePicker.delegate = self
          self.present(imagePicker, animated: true, completion: nil)
        }
      })
      let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {(action) in
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          let imagePicker = UIImagePickerController()
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .photoLibrary
          imagePicker.delegate = self
          self.present(imagePicker, animated: true, completion: nil)
        }
      })
      photoSourceRequestController.addAction(cameraAction)
      photoSourceRequestController.addAction(photoLibraryAction)
      
      // for ipad
      if let popoverController = photoSourceRequestController.popoverPresentationController {
        if let cell = tableView.cellForRow(at: indexPath) {
          popoverController.sourceView = cell
          popoverController.sourceRect = cell.bounds
        }
      }
      present(photoSourceRequestController, animated: true, completion: nil)
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.separatorStyle = .none
    
  }
  
}
