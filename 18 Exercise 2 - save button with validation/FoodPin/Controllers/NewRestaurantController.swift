//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Rami on 12/20/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController,
UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    
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
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let errorType = self.validateInput()
        
        if errorType.isEmpty {
            let alertController =
                UIAlertController(title: "Oops", message:
                    "We can't continue because you need to fill in the \(errorType) field",
                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        print("Name: \(nameTextField.text ?? "")")
        print("Type: \(typeTextField.text ?? "")")
        print("Location: \(addressTextField.text ?? "")")
        print("Phone: \(phoneTextField.text ?? "")")
        print("Description: \(descriptionTextView.text ?? "")")
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField)
        -> Bool {

            if let nextTextField = view.viewWithTag(textField.tag + 1) {
                textField.resignFirstResponder()
                nextTextField.becomeFirstResponder()
            }
            return true
    }
    
    func validateInput() -> String {
        var error = ""
        if let text = nameTextField.text, !text.isEmpty {
            error = "name"
        } else if let text = typeTextField.text, !text.isEmpty {
            error = "type"
        } else if let text = addressTextField.text, !text.isEmpty {
            error = "address"
        } else if let text = phoneTextField.text, !text.isEmpty {
            error = "phone"
        } else if let text = descriptionTextView.text, !text.isEmpty {
            error = "description"
        }
        return error
    }
    
    // MARK: - UIImagePickerControllerDelegate methods

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }

        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        // I use `photoImageView.superview!` below because I don't know the exact context.
        // If photoImageView is child view of viewController.view, you can do just `view.(...)Anchor`
        photoImageView.leadingAnchor.constraint(equalTo: photoImageView.superview!.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: photoImageView.superview!.trailingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: photoImageView.superview!.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: photoImageView.superview!.bottomAnchor).isActive = true
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(
                title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {(_) in
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
        
        // Configure navigation bar appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes =
                [ NSAttributedString.Key.foregroundColor: UIColor(red: 231,
                                                                  green: 76,
                                                                  blue: 60),
                  NSAttributedString.Key.font: customFont ]
        }
    }
    
}
