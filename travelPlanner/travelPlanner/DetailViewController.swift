//
//  DetailViewController.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/13/23.
//

import UIKit
import Nuke


class DetailViewController: UIViewController, UITableViewDataSource {
    
    private var reviewsArray: [Review] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure, and return a table view cell for the given row (i.e., `indexPath.row`)

           print("🍏 cellForRowAt called for row: \(indexPath.row)")

           let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell

           // Get the movie associated table view row
           let review = reviewsArray[indexPath.row]

           // Configure the cell (i.e., update UI elements like labels, image views, etc.)

           // Set the text on the labels
        cell.usernameLabel.text = review.user.name
        print(review.text, "😋")
        cell.reviewLabel.text = review.text

           // Return the cell for use in the respective table view row
           return cell
    }
    
    
    @IBOutlet weak var activImageView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var zipLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func didTapButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // 1.
            itinerary.addToFavorites()
        } else {
            // 2.
            itinerary.removeFromFavorites()
        }
    }
    
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    var itinerary: Business!

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        
        reviewTableView.dataSource = self
        
        fetchReviews()

        let favorites = Business.getMovies(forKey: Business.favoritesKey)
        // 2.
        if favorites.contains(itinerary) {
            // 3.
            favoriteButton.isSelected = true
        } else {
            // 4.
            favoriteButton.isSelected = false
        }
        
        
        if let address = itinerary.location.address1 {

            addressLabel.text = address
        } else {

            // if vote average is nil, set vote average label text to empty string
            addressLabel.text = ""
        }
        
        cityLabel.text = itinerary.location.city
        zipLabel.text = itinerary.location.zipCode
        ratingLabel.text = String(itinerary.rating)
        
        
        
        if let posterPath = itinerary.imageUrl,

        // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
        let imageUrl = URL(string: posterPath) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: imageUrl, into: activImageView)
        }

    }
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // MARK: - Pass the selected movie data
//
//        // Get the index path for the selected row.
//        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
//        guard let selectedIndexPath = reviewTableView.indexPathForSelectedRow else { return }
//
//        // Get the selected movie from the movies array using the selected index path's row
//        let selectedReview = reviewsArray[selectedIndexPath.row]
//
//        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
//        guard let detailViewController = segue.destination as? DetailViewController else { return }
//
//        detailViewController. = selectedReview
//    }
    
    private func fetchReviews() {

        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer ZSBxj-kAT9Uz-DY7tlMBNTQ8rjv28qQ4yWztK4k50-RfZ2ct0wP6a0XdjXGXVnNDUyFJui7cp9Bwl4w3oladh1xAg15cC4oK-XnS0SNhqmDN22cwSGt8S7prd91PZXYx"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/5vVD0YxnyJjg-CXUbNGLQA/reviews?limit=20&sort_by=yelp_sort")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request as URLRequest as URLRequest) { data, response, error in

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
                // MARK: - jSONDecoder with custom date formatter
                let decoder = JSONDecoder()

                // Create a date formatter object
                let dateFormatter = DateFormatter()

                // Set the date formatter date format to match the the format of the date string we're trying to parse
                dateFormatter.dateFormat = "yyyy-MM-dd"

                // Tell the json decoder to use the custom date formatter when decoding dates
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                // Decode the JSON data into our custom `MovieFeed` model.
                let reviewResponse = try JSONDecoder().decode(ReviewsData.self, from: data)

                // Access the array of movies
                let reviews = reviewResponse.reviews

                // Run any code that will update UI on the main thread.
                DispatchQueue.main.async { [weak self] in

                    // We have movies! Do something with them!
                    print("✅ SUCCESS!!! Fetched \(reviews.count) movies")

//                     Iterate over all movies and print out their details.
                    for (index, reviews) in reviews.enumerated() {
                        print("🍿 review \(index) ------------------")
                        print("user: \(reviews.user.id)")
                        print("Overview: \(reviews.text)")
                    }

                    // MARK: - Update the movies property so we can access movie data anywhere in the view controller.
                    // print("🍏 Fetched and stored \(movies.count) movies")

                    // Prompt the table view to reload its data (i.e. call the data source methods again and re-render contents)
                    self?.reviewsArray = reviews
                    self?.reviewTableView.reloadData()
                }
            } catch {
                print("🚨 Error decoding JSON data into Movie Response: \(error.localizedDescription)")
                return
            }
        }

        // Don't forget to run the session!
        session.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    

}
