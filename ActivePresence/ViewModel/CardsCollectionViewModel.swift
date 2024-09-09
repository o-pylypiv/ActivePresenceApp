//
//  CardsCollectionViewModel.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import Foundation

class CardsCollectionViewModel {
    
    var cardViewModels: [CardViewModel] = [] {
        didSet {
            reloadCollectionView?()
        }
    }
    
    var reloadCollectionView: (() -> Void)?
    var showError: ((String) -> Void)?
    
    func fetchCards() {
        NetworkManager.shared.fetchCards { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self?.cardViewModels = cards.map { CardViewModel(card: $0) }
                case .failure(let error):
                    self?.showError?(error.rawValue)
                }
            }
        }
    }
    
    func numberOfItems() -> Int {
        return cardViewModels.count
    }
    
    func cardViewModel(at indexPath: IndexPath) -> CardViewModel {
        return cardViewModels[indexPath.row]
    }
    
}

