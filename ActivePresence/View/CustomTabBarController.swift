//
//  CustomTabBarController.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 09.09.2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(resource: .home).withRenderingMode(.alwaysOriginal)
        items[1].image = UIImage(resource: .chatGroup).withRenderingMode(.alwaysOriginal)
        items[2].image = UIImage(resource: .abbBtnGroup).withRenderingMode(.alwaysOriginal)
        items[3].image = UIImage(resource: .explore).withRenderingMode(.alwaysOriginal)
        items[4].image = UIImage(resource: .profile2).withRenderingMode(.alwaysOriginal)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabBarColor
 
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.stackedLayoutAppearance = itemAppearance
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
}
