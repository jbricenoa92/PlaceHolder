//
//  placeHolderCellTableViewCell.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 26/04/23.
//

import UIKit

class placeHolderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserPhone: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var BtnPublication: UIButton!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(users: User?){
     
        if let email = users?.email {
            self.lblUserEmail?.text = email
        }
       // index = users?.id
        self.lblUserName?.text =  users?.name ?? ""
        self.lblUserPhone?.text = users?.phone ?? ""
        
    }

}
