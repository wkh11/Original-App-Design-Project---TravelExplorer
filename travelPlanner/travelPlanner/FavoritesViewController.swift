//
//  FavoritesViewController.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/16/23.
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    var favoriteItinerary: [Business] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Anything in the defer call is guaranteed to happen last
        defer {
            // Show the "Empty Favorites" label if there are no favorite movies
            emptyFavoritesLabel.isHidden = !favoriteItinerary.isEmpty
        }

        // TODO: Get favorite movies and display in table view
        // Get favorite movies and display in table view
        // 1. Get the array of favorite movies
        // 2. Set the favoriteMovies property so the table view data source methods will have access to latest favorite movies.
        // 3. Reload the table view
        // ------

        // 1.
        let movies = Business.getMovies(forKey: Business.favoritesKey)
        // 2.
        self.favoriteItinerary = movies
        // 3.
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(favoriteItinerary.count, "fes")
        return favoriteItinerary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryCell", for: indexPath) as! ItineraryCell

        print(cell, "🙃")
        // Get the movie associated table view row
        
        if (cell.locationImageView != nil) {
            print("location view exists")
        }
        else {
            print("doesnt exist")
        }
        
        let itinerary = favoriteItinerary[indexPath.item]

        // Configure the cell (i.e. update UI elements like labels, image views, etc.)

        // Unwrap the optional poster path
        if let posterPath = itinerary.imageUrl,
        let imageUrl = URL(string: posterPath) {
            print(posterPath)
            print(imageUrl, "✊")

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: imageUrl, into: cell.locationImageView)
        }

        // Set the text on the labels
        cell.placeLabel.text = itinerary.name
        cell.locationLabel.text = itinerary.location.address1

        // Return the cell for use in the respective table view row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // MARK: - Pass the selected movie to the Detail View Controller

        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedMovie = favoriteItinerary[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.itinerary = selectedMovie
    }

}
