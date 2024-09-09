//
//  NetworkManager.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//


import UIKit

protocol NetworkManagerProtocol {
    
    func fetchCards(completion: @escaping (Result<[Card], APNetworkingError>) -> Void)
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
    
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private let baseURL = "https://orbol-backend.vercel.app/api/details/"
    let cache = NSCache<NSString, UIImage>()
    
    func fetchCards(completion: @escaping (Result<[Card], APNetworkingError>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cards = try decoder.decode([Card].self, from: data)
                completion(.success(cards))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
}
