//
//  CustomTabBar.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 09.09.2024.
//

import UIKit

class CustomTabBar: UITabBar {
    
    private var selectionIndicator: UIView!
    var selectedItemKey = "selectedItem"
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 120
        return sizeThatFits
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    private func setupSelectionIndicator() {

        if selectionIndicator == nil {
            selectionIndicator = UIView()
            selectionIndicator.backgroundColor = .accentOne
            selectionIndicator.layer.cornerRadius = 2
            self.addSubview(selectionIndicator)
        }

        if let items = self.items, let selectedItem = self.selectedItem {
            let index = items.firstIndex(of: selectedItem) ?? 0
            let itemWidth = self.bounds.width / CGFloat(items.count)
            let indicatorWidth: CGFloat = 45.0
            let indicatorHeight: CGFloat = 3.0
            
            selectionIndicator.frame = CGRect(
                x: (itemWidth * CGFloat(index)) + (itemWidth - indicatorWidth) / 2,
                y: 0,
                width: indicatorWidth,
                height: indicatorHeight
            )
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addObserver(self, forKeyPath: selectedItemKey, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == selectedItemKey {
            setupSelectionIndicator()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: selectedItemKey)
    }
    
}
