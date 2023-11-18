//
//  Itinerary.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/12/23.
//

import Foundation

// Main struct representing the whole JSON response
struct ApiResponse: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region
}

extension Business {

    static var favoritesKey: String {
        return "Favorites"
    }

    static func save(_ movies: [Business], forKey key: String) {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        let encodedData = try! JSONEncoder().encode(movies)
        // 3.
        defaults.set(encodedData, forKey: key)
    }

    static func getMovies(forKey key: String) -> [Business] {
        // 1.
        let defaults = UserDefaults.standard
        // 2.
        if let data = defaults.data(forKey: key) {
            // 3.
            let decodedMovies = try! JSONDecoder().decode([Business].self, from: data)
            // 4.
            return decodedMovies
        } else {
            // 5.
            return []
        }
    }
    
    func addToFavorites() {
        // 1.
        var favoriteMovies = Business.getMovies(forKey: Business.favoritesKey)
        // 2.
        favoriteMovies.append(self)
        // 3.
        Business.save(favoriteMovies, forKey: Business.favoritesKey)
    }

    // Removes the movie from the favorites array in UserDefaults
    // 1. Get all favorite movies from UserDefaults
    // 2. remove all movies from the array that match the movie instance this method is being called on (i.e. `self`)
    //   - The `removeAll` method iterates through each movie in the array and passes the movie into a closure where it can be used to determine if it should be removed from the array.
    // 3. If a given movie passed into the closure is equal to `self` (i.e. the movie calling the method) we want to remove it. Returning a `Bool` of `true` removes the given movie.
    // 4. Save the updated favorite movies array.
    func removeFromFavorites() {
        // 1.
        var favoriteMovies = Business.getMovies(forKey: Business.favoritesKey)
        // 2.
        favoriteMovies.removeAll { Business in
            // 3.
            return self == Business
        }
        // 4.
        Business.save(favoriteMovies, forKey: Business.favoritesKey)
    }

}

// Business struct for each business in the array
struct Business: Codable, Equatable {
    let id: String
    let alias: String
    let name: String
    let imageUrl: String?
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Coordinates
    let transactions: [String]
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case id, alias, name, categories, rating, coordinates, transactions, location, phone, distance
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
    }
}

// Category struct for the categories array within each business
struct Category: Codable, Equatable {
    let alias: String
    let title: String
}

// Coordinates struct for the coordinates object within each business
struct Coordinates: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}

// Location struct for the location object within each business
struct Location: Codable, Equatable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city, country, state
        case zipCode = "zip_code"
        case displayAddress = "display_address"
    }
}

// Region struct for the region object in the JSON response
struct Region: Codable, Equatable {
    let center: Coordinates
}
