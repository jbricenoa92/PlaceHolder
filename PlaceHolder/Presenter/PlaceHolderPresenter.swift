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
    
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }

 
}
