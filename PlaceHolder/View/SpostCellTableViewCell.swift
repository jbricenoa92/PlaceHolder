//
//  SpostCellTableViewCell.swift
//  PlaceHolder
//
//  Created by Juan Diego Briceño A on 27/04/23.
//

import UIKit

class SpostCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(post:Post?){
        self.title.text = post?.title
        self.body.text = post?.body
        
    }
    
}
