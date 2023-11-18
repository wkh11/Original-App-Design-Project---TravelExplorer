//
//  ViewController.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/12/23.
//

import UIKit
import Foundation
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    
    private var itinerariesArray: [Business] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itinerariesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure, and return a table view cell for the given row (i.e., `indexPath.row`)

           print("🍏 cellForRowAt called for row: \(indexPath.row)")

           // Get a reusable cell
           // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps optimize table view performance as the app only needs to create enough cells to fill the screen and reuse cells that scroll off the screen instead of creating new ones.
           // The identifier references the identifier you set for the cell previously in the storyboard.
           // The `dequeueReusableCell` method returns a regular `UITableViewCell`, so we must cast it as our custom cell (i.e., `as! MovieCell`) to access the custom properties you added to the cell.
           let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryCell", for: indexPath) as! ItineraryCell

           // Get the movie associated table view row
           let itinerary = itinerariesArray[indexPath.row]

           // Configure the cell (i.e., update UI elements like labels, image views, etc.)

           // Unwrap the optional poster path
        
//        Nuke.loadImage(with: itinerary.imageUrl as! ImageRequestConvertible, into: cell.locationImageView)
        
        
        if let posterPath = itinerary.imageUrl,

           let imageUrl = URL(string: posterPath) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
            Nuke.loadImage(with: imageUrl, into: cell.locationImageView)
        }

           // Set the text on the labels
           cell.placeLabel.text = itinerary.name
           cell.locationLabel.text = itinerary.location.address1

           // Return the cell for use in the respective table view row
           return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        fetchItinerary()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // MARK: - Pass the selected movie data

        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedItinerary = itinerariesArray[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.itinerary = selectedItinerary
    }
    
    
    // Fetches a list of popular itineraries from the Yelp Fusion API
    private func fetchItinerary() {
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer ZSBxj-kAT9Uz-DY7tlMBNTQ8rjv28qQ4yWztK4k50-RfZ2ct0wP6a0XdjXGXVnNDUyFJui7cp9Bwl4w3oladh1xAg15cC4oK-XnS0SNhqmDN22cwSGt8S7prd91PZXYx"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/search?location=NYC&term=tourist&sort_by=best_match&limit=20")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            // Check for errors
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                return
            }
            
            // Check for server errors
            // Make sure the response is within the `200-299` range (the standard range for a successful response).
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }
            
            // Check for data
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }
            
            // The JSONDecoder's decode function can throw an error. To handle any errors we can wrap it in a `do catch` block.
            do {
                
                // Decode the JSON data into our custom `MovieResponse` model.
                let itineraryResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                
                // Access the array of movies
                let itineraries = itineraryResponse.businesses
                
                // Run any code that will update UI on the main thread.
                DispatchQueue.main.async { [weak self] in
                    
                    // We have movies! Do something with them!
                    print("✅ SUCCESS!!! Fetched \(itineraries.count) movies")
                    
                    // Iterate over all movies and print out their details.
                    for itinerary in itineraries {
                        print("🍿 Activity ------------------")
                        print("Title: \(itinerary.name)")
                        print("Overview: \(itinerary.location.address1)")
                    }
                    
                    // TODO: Store movies in the `movies` property on the view controller
                    self?.itinerariesArray = itineraries
                    self?.tableView.reloadData()
                    
                }
            } catch {
                print("🚨 Error decoding JSON data into Movie Response: \(error.localizedDescription)")
                return
            }
        }
        
        // Don't forget to run the session!
        session.resume()
    }
    
}
