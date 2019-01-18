//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Rami on 12/11/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    var restaurant: RestaurantMO!

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!

    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: {
            if let rating = segue.identifier {
                self.restaurant.rating = rating
                self.headerView.ratingImageView.image = UIImage(named: rating)
                
                let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                self.headerView.ratingImageView.transform = scaleTransform
                self.headerView.ratingImageView.alpha = 0
                // bounce in effect
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0,
                    usingSpringWithDamping: 0.3,
                    initialSpringVelocity: 0.7,
                    options: [],
                    animations: {
                        self.headerView.ratingImageView.transform = .identity
                        self.headerView.ratingImageView.alpha = 1
                }, completion: nil)
            }
        })
    }
    // MARK: - Functions

    // MARK: - UITableViewDataSource Protocol
    func numberOfSections(in tableView: UITableView)
        -> Int {
            return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
        -> Int {
            return 5
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            switch indexPath.row {
            case 0:
                // using this version (describing) instead of other will show errors if the cell ID isn't found
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(
                    describing: RestaurantDetailIconTextCell.self), for: indexPath)
                    as? RestaurantDetailIconTextCell else {
                        print("error pulling phone number")
                        return UITableViewCell()
                }
                cell.iconImageView.image = UIImage(named: "phone")
                cell.shortTextLabel.text = restaurant.phone
                cell.selectionStyle = .none
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(
                    describing: RestaurantDetailIconTextCell.self), for: indexPath)
                    as? RestaurantDetailIconTextCell else {
                        print("error pulling map")
                        return UITableViewCell()
                }
                cell.iconImageView.image = UIImage(named: "map")
                cell.shortTextLabel.text = restaurant.location
                cell.selectionStyle = .none
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(
                    describing: RestaurantDetailTextCell.self), for: indexPath)
                    as? RestaurantDetailTextCell else {
                        print("error pulling description")
                        return UITableViewCell()
                }
                cell.descriptionLabel.text = restaurant.description
                cell.selectionStyle = .none
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(
                    describing: RestaurantDetailSeparatorCell.self), for: indexPath)
                    as? RestaurantDetailSeparatorCell else {
                        print("error pulling label")
                        return UITableViewCell()
                }
                cell.titleLabel.text = "HOW TO GET HERE"
                cell.selectionStyle = .none
                return cell
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(
                    describing: RestaurantDetailMapCell.self), for: indexPath)
                    as? RestaurantDetailMapCell else {
                        print("error pulling location")
                        return UITableViewCell()
                }
                if let restaurantLocation = restaurant.location {
                    cell.configure(location: restaurantLocation)
                }

                cell.selectionStyle = .none
                return cell
            default:
                fatalError("Failed to instantiate the table view cell for detail view controller")
            }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            guard let destinationController = segue.destination as? MapViewController else {
                print("segue mapview error")
                return
            }
            destinationController.restaurant = restaurant
        } else if segue.identifier == "showReview" {
            guard let destinationController = segue.destination as? ReviewViewController else {
                print("segue show review error")
                return
            }
            destinationController.restaurant = restaurant
        }
    }

    // MARK: - View controller life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // show nav bar just for this scene
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize nav bar
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        // keeps the nav bar from blocking the top content (default is .always)
        tableView.contentInsetAdjustmentBehavior = .never
        
        // link data
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // configure header view
        if let restaurantImage = restaurant.image {
            headerView.headerImageView.image = UIImage(data: restaurantImage as Data)
        }
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.backgroundTypeLabel.text = "   " + restaurant.type! + "   "
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
    }
    
}
