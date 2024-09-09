//
//  APNetworkingError.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import Foundation

enum APNetworkingError: String, Error {
    
    case invalidURL = "This URL is invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case decodingError = "The decoding error has ocuured. Please try again."
    
}
