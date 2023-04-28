//
//  SessionManager.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 27/04/23.
//

import Foundation
import SwiftKeychainWrapper

protocol SessionManagerProtocol {
    static func saveUser(codable: String?)
    static func getUser() -> String?
}

class SessionManager: SessionManagerProtocol {
        
    static func saveUser(codable: String?) {
        if let codable = codable {
            UserDefaults.standard.set(codable, forKey: GlobalConstants.KeySession.userData)
            UserDefaults.standard.synchronize()
        } else {
            print("error saving on SessionManager")
        }
    }
    
    static func getUser() -> String? {
        if let codable:String =
            UserDefaults.standard.string(forKey: GlobalConstants.KeySession.userData) {
            return codable
        }
        return nil
    }
    
    
    
}
