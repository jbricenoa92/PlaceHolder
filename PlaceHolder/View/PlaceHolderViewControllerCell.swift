//
//  PlaceHolderViewControllerCell.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 25/04/23.
//

import UIKit

protocol PlaceHolderViewControllerCellDelegate: AnyObject {
    func showPublications(index: Int)
}

class PlaceHolderViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserPhone: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    weak var delegate: PlaceHolderViewControllerCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(users: User?){
        if let email = users?.email {
            self.lblUserEmail?.text = email
        }
        index = users?.id
        self.lblUserName?.text =  users?.name ?? ""
        self.lblUserPhone?.text = users?.phone ?? ""
        
    }
    
    @IBAction func publicationPress(_ sender: Any) {
        self.delegate?.showPublications(index: index!)
    }
    
    
}
