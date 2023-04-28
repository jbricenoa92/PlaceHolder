//
//  GlobalConstants.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 24/04/23.
//

import Foundation
import UIKit


struct GlobalConstants {
    
    struct Colors {
        
        static let base: UIColor = UIColor(named: "ceibaBase")!
    }
    
    struct UrlServices {
        
        static let basePlaceHolder: String = "https://jsonplaceholder.typicode.com/"
        static let usersPlaceHolder: String = "users"
        static let postsPlaceHolder: String = "posts"
        static let postsByIdPlaceHolder: String = "posts?userId="
    }
    
    struct KeySession {
        
        static let userData = "userData"
    }
}
