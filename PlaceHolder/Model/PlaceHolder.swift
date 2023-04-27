//
//  PlaceHolder.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 25/04/23.
//

import Foundation


struct User: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    var index: Int?
    var isOpened: Bool? = false
    var publication: [Publications]?
}

struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

struct Geo: Codable {
    var lat: String?
    var lng: String?
}

struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

struct Publications: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

struct Post: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var isOpened: Bool? = false
}

 
class publicationsModel {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var isOpened: Bool? = false
    
    init(userId: Int, id: Int, title: String, body: String, isOpened: Bool = false) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.isOpened = isOpened
    }
}

