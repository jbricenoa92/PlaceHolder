//
//  PostPresenter.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 27/04/23.
//

import UIKit

protocol PostPresenterDelegate: AnyObject {
    func getPresenterPost(post:[Post])
    func getPresenterPostById(post:[Post])
}

typealias PresenterDelegatePost = PostPresenterDelegate & UIViewController

class PostPresenter {
    
    weak var delegate: PresenterDelegatePost?
    private var service = services()

    func getPostFromService(){
        service.getPosts{ (post, error) in
            if post != nil && error == nil {
                self.delegate?.getPresenterPost(post: post ?? [])
            }
            
            
        }
    }
    
    func getPostByIdFromService(id: Int){
        service.getPostsById(id: id, completion:{ (getpost, error) in
            
            if getpost != nil && error == nil {
                self.delegate?.getPresenterPostById(post: getpost ?? [])
            }
            
            
        })
    }

    public func setViewDelegate(delegate: PresenterDelegatePost){
        self.delegate = delegate
    }
}
