//
//  CardViewModel.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import UIKit

class CardViewModel {
    
    private let card: Card
    var title: String { return card.title }
    var shortDescription: String { return card.shortDescription }
    var networkManager = NetworkManager.shared
    
    var backgroundImage: ((UIImage?) -> Void)?
    var logoImage: ((UIImage?) -> Void)?
    
    init(card: Card) {
        self.card = card
    }
    
    func fetchBackgroundImage() {
        networkManager.downloadImage(from: card.backgroundImageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImage?(image)
            }
        }
    }

    func fetchLogoImage() {
        let logoImagePngUrl = card.logoImageURL.replacingOccurrences(of: ".svg", with: ".png")

        networkManager.downloadImage(from: logoImagePngUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.logoImage?(image)
            }
        }
    }
    
}
