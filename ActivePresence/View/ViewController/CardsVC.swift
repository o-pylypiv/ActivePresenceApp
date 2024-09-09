//
//  CardsVC.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import UIKit

class CardsVC: UIViewController {
    
    var collectionView: UICollectionView!
    let viewModel = CardsCollectionViewModel()
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        setupCollectionView()
        bindViewModel()
        showLoadingView()
        viewModel.fetchCards()
    }
    
    private func setUpViewController() {
        title = "ActivePresence"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.customTitle,
            NSAttributedString.Key.foregroundColor: UIColor.titleColor
        ]
        view.backgroundColor = .backgroundOne
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 300)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundOne
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.reloadCollectionView = { [weak self] in
            self?.dismissLoadingView()
            self?.collectionView.reloadData()
        }
        
        viewModel.showError = { [weak self] errorMessage in
            self?.dismissLoadingView()
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Loading View Methods
    
    func showLoadingView() {
        if containerView != nil { return }
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            if self.containerView != nil {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
    
}

extension CardsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseID, for: indexPath) as! CardCell
        cell.viewModel = viewModel.cardViewModel(at: indexPath)
        return cell
    }
    
}


