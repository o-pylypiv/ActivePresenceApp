//
//  Card.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import Foundation

struct Card: Codable {
    
    let id: String
    let cardId: String
    let title: String
    let shortDescription: String
    let backgroundImageURL: String
    let logoImageURL: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case cardId = "card_id"
        case title
        case shortDescription = "short_description"
        case backgroundImageURL = "background_image_url"
        case logoImageURL = "logo_image_url"
        case createdAt
        case updatedAt
        
    }
    
}

