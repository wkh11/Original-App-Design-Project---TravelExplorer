//
//  Review.swift
//  travelPlanner
//
//  Created by He, Wei Kang on 11/17/23.
//

struct ReviewsData: Codable, Equatable {
    let reviews: [Review]
    let total: Int
    let possibleLanguages: [String]
    
    enum CodingKeys: String, CodingKey {
        case reviews, total
        case possibleLanguages = "possible_languages"
    }
}

struct Review: Codable, Equatable {
    let id: String
    let url: String
    let text: String
    let rating: Int
    let timeCreated: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, url, text, rating, user
        case timeCreated = "time_created"
    }
}

struct User: Codable, Equatable {
    let id: String
    let profileUrl: String
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case profileUrl = "profile_url"
        case imageUrl = "image_url"
    }
}
