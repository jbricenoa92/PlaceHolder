//
//  services.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 25/04/23.
//

import Foundation
import UIKit

class services {
    
    
    public func getUsers(completion: @escaping ([User]?, NSError?) -> Void){
        guard let url = URL(string: GlobalConstants.UrlServices.basePlaceHolder+GlobalConstants.UrlServices.usersPlaceHolder) else {
            return
        }        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let users = try? JSONDecoder().decode([User].self, from: data)
                if let user = users {
                    completion(user, nil)
                    return
                }
            }
            catch {
                completion(nil, nil)
                print("error",error)
            }
        }
        task.resume()
    }
    
    public func getPosts(completion: @escaping ([Publications]?, NSError?) -> Void){
        guard let url = URL(string: GlobalConstants.UrlServices.basePlaceHolder+GlobalConstants.UrlServices.postsPlaceHolder) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let publications = try? JSONDecoder().decode([Publications].self, from: data)
                if let publication = publications {
                    completion(publication, nil)
                    return
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func getPostsById(id: String,completion: @escaping ([Publications]?, NSError?) -> Void){
        guard let url = URL(string: GlobalConstants.UrlServices.basePlaceHolder+GlobalConstants.UrlServices.postsByIdPlaceHolder+id) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let publications = try? JSONDecoder().decode([Publications].self, from: data)
                if let publication = publications {
                    completion(publication, nil)
                    return
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
