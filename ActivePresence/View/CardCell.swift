//
//  CardCell.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    static let reuseID = "CardCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let backgroundImageView = UIImageView()
    let logoImageView = UIImageView()
    let gradientView = UIView()
    
    var viewModel: CardViewModel? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        contentView.addSubview(backgroundImageView)

        gradientView.backgroundColor = UIColor.clear
        contentView.addSubview(gradientView)

        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.backgroundColor = .white
        logoImageView.layer.cornerRadius = 10
        contentView.addSubview(logoImageView)

        titleLabel.font = UIFont.customCardTitle
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        
        descriptionLabel.font = UIFont.customBody
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        contentView.addSubview(descriptionLabel)
        
        layoutUI()
        addGradientLayer()
    }
    
    private func layoutUI() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.7).cgColor, 
            UIColor.black.withAlphaComponent(0.42).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientView.frame = contentView.bounds
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.shortDescription
        
        backgroundImageView.image = UIImage(resource: .placeholder)
        logoImageView.image = UIImage(resource: .placeholderLogo)

        viewModel.backgroundImage = { [weak self] image in
            self?.backgroundImageView.image = image
        }
        
        viewModel.logoImage = { [weak self] image in
            self?.logoImageView.image = image
        }
        
        viewModel.fetchBackgroundImage()
        viewModel.fetchLogoImage()
    }
    
}
