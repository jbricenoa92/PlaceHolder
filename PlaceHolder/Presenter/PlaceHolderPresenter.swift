//
//  Presenter.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 25/04/23.
//

import Foundation
import UIKit

protocol PlaceHolderPresenterDelegate: AnyObject {
    
    func getPresenterUser(users:[User])
    func getPresenterPost(publication:[Publications])
    func getPresenterPostById(publication:[Publications])
}

typealias PresenterDelegate = PlaceHolderPresenterDelegate & UIViewController

class PlaceHolderPresenter {
    
    
    weak var delegate: PresenterDelegate?
    private var service = services()
    
    func getuserFromService(){
        service.getUsers{ (user, error) in
            
            if user != nil && error == nil {
                self.delegate?.getPresenterUser(users: user ?? [])
            }
            
            
        }
    }
    func getPostFromService(){
        service.getPosts{ (post, error) in
            if post != nil && error == nil {
                self.delegate?.getPresenterPost(publication: post ?? [])
            }
            
            
        }
    }
    
    func getPostByIdFromService(id: String){
        service.getPostsById(id: id, completion:{ (post, error) in
            if post != nil && error == nil {
                self.delegate?.getPresenterPostById(publication: post ?? [])
            }
            
            
        })
    }
    
    
    
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
 
}
