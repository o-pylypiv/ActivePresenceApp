//
//  APFonts.swift
//  ActivePresence
//
//  Created by Olha Pylypiv on 06.09.2024.
//

import UIKit

extension UIFont {
    
    static var customTitle: UIFont {
        return UIFont(name: "KhmerMN", size: 24) ?? UIFont.systemFont(ofSize: 24)
    }

    static var customCardTitle: UIFont {
        return UIFont(name: "TAN-MONCHERI", size: 24) ?? UIFont.systemFont(ofSize: 24)
    }

    static var customBody: UIFont {
        return UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
}
