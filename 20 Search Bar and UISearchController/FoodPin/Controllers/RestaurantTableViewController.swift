//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Rami on 12/1/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Enums | Extensions
// MARK: - IBActions

class RestaurantTableViewController: UITableViewController,
NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    // MARK: - Variables
    var restaurants: [RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var searchController: UISearchController!
    var searchResults: [RestaurantMO] = []

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet var emptyRestaurantView: UIView!

    // MARK: - Functions

    // MARK: - NSFetchedResultsControllerDelegate methods

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?
        ) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            // swiftlint:disable force_cast
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // using filter closure to return matches
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

    // MARK: - Override Functions

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView)
        -> Int {
            if restaurants.count >= 1 {
                tableView.backgroundView?.isHidden = true
                tableView.separatorStyle = .singleLine
            } else {
                tableView.backgroundView?.isHidden = false
                tableView.separatorStyle = .none
            }

            return 1  // this is the default value
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int)
        -> Int {
            return restaurants.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            let cellIdentifier = "datacell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? RestaurantTableViewCell else {
                    print("error removing datacell")
                    return UITableViewCell()
            }
            cell.nameLabel.text = restaurants[indexPath.row].name
            if let restaurantImage = restaurants[indexPath.row].image {
                cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
            }
            cell.locationLabel.text = restaurants[indexPath.row].location
            cell.typeLabel.text = restaurants[indexPath.row].type
            cell.heartImageView.isHidden = restaurants[indexPath.row].isVisited ? false : true

            return cell
    }

    // MARK: - TableView actions

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
                // delete the row from the data source
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let context = appDelegate.persistentContainer.viewContext
                    let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                    context.delete(restaurantToDelete)

                    appDelegate.saveContext()
                }

                // call completion handler to dismiss the action button
                completionHandler(true)
            }

            let shareAction = UIContextualAction(style: .normal, title: "Share") { (_, sourceView, completionHandler) in
                let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
                let activityController: UIActivityViewController
                
                if let restaurantImage = self.restaurants[indexPath.row].image,
                    let imageToShare = UIImage(data: restaurantImage as Data) {
                    activityController = UIActivityViewController(
                        activityItems: [defaultText, imageToShare], applicationActivities: nil)
                } else {
                    activityController = UIActivityViewController(
                        activityItems: [defaultText], applicationActivities: nil)
                }

                // fix for iPad
                if let popoverController = activityController.popoverPresentationController {
                    if let cell = tableView.cellForRow(at: indexPath) {
                        popoverController.sourceView = cell
                        popoverController.sourceRect = cell.bounds
                    }
                }
                self.present(activityController, animated: true, completion: nil)
                completionHandler(true)
            }
            
            // color the options w/ specific color
            deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            deleteAction.image = UIImage(named: "delete")
            shareAction.backgroundColor = UIColor.orange   // simple color
            shareAction.image = UIImage(named: "share")

            // show the options
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
            return swipeConfiguration
    }

    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {

            let checkInAction = UIContextualAction(style: .normal, title: "Check In") { (_, _, completionHandler) in
                // check-in
                guard let cell = tableView.cellForRow(at: indexPath)
                    as? RestaurantTableViewCell else {
                        print("error with check-in")
                        return
                }
                self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
                cell.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false : true

                // call completion handler to dismiss the action button
                completionHandler(true)
            }

            // color the options
            let checkInIcon = restaurants[indexPath.row].isVisited ? "undo" : "tick"
            // using the extension here for simplier color choice
            checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
            checkInAction.image = UIImage(named: checkInIcon)
            
            // show the options
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
            return swipeConfiguration
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destinationController = segue.destination as? RestaurantDetailViewController else {
                    print("segue error")
                    return
                }
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }

    // MARK: - View controller life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // hide nav bar just for this scene
        navigationController?.hidesBarsOnSwipe = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //nav bar customization
        navigationController?.navigationBar.prefersLargeTitles = true
        // to make background transparent, set image and shadow to blank UIImage
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController

        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
                NSAttributedString.Key.font: customFont
            ]
        }

        // prepare the empty view
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = true

        tableView.separatorStyle = .none

        // adjust width on iPad only
        tableView.cellLayoutMarginsFollowReadableWidth = true

        // fetch data from data store
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            fetchResultController.delegate = self

            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }

    }
}
